import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:vision_bot_mobile_app/core/errors/exceptions.dart';
import 'package:vision_bot_mobile_app/core/services/websocket/web_socket_state.dart';
import 'package:vision_bot_mobile_app/core/utils/typedefs.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketClient {
  WebSocketClient({
    required String uri,
    Duration reconnectInterval = const Duration(seconds: 5),
  }) : _uri = uri,
       _reconnectInterval = reconnectInterval;

  final String _uri;
  final Duration _reconnectInterval;

  late WebSocketChannel _channel;
  StreamSubscription<dynamic>? _subscription;

  bool _connected = false;
  bool _manuallyDisconnected = false;

  final Map<String, StreamController<DataMap>> _topicControllers = {};
  final Set<String> _subscribedTopics = {};
  final Set<String> _publishedTopics = {};

  Timer? _reconnectTimer;

  final StreamController<WebSocketState> _connectionController =
      StreamController<WebSocketState>.broadcast();

  bool get isConnected => _connected;

  StreamController<WebSocketState> get streamController =>
      _connectionController;

  static const _logPrefix = '[WebSocketClient]';

  Future<void> connect() async {
    if (_connected) {
      log('$_logPrefix Already connected', name: 'WS');
      return;
    }

    log('$_logPrefix Connecting to $_uri', name: 'WS');

    try {
      _connectionController.add(WebSocketState.loading);
      _channel = WebSocketChannel.connect(Uri.parse(_uri));
      await _channel.ready;

      _subscription = _channel.stream.listen(
        _handleMessage,
        onError: (dynamic error) {
          log('$_logPrefix Stream error: $error', name: 'WS', error: error);
          _handleDisconnect();
        },
        onDone: () {
          log('$_logPrefix Connection closed by server', name: 'WS');
          _handleDisconnect();
        },
      );

      _connected = true;
      _manuallyDisconnected = false;
      log('$_logPrefix Connected successfully', name: 'WS');
      _connectionController.add(WebSocketState.connected);
      _reconnectTimer?.cancel();
    } catch (e, stack) {
      log(
        '$_logPrefix Connection failed',
        name: 'WS',
        error: e,
        stackTrace: stack,
      );

      _connected = false;
      _connectionController.add(WebSocketState.failed);
      _scheduleReconnect();

      throw WebSocketException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }

  Future<void> disconnect() async {
    log('$_logPrefix Manual disconnect requested', name: 'WS');

    _manuallyDisconnected = true;

    try {
      await _subscription?.cancel();
      await _channel.sink.close();
    } on Exception catch (e) {
      log('$_logPrefix Error while disconnecting: $e', name: 'WS');
    }

    await _clearConnection();
    _connectionController.add(WebSocketState.disconnected);
    _publishedTopics.clear();
    log('$_logPrefix Disconnected', name: 'WS');
  }

  void publish({
    required String topic,
    required DataMap message,
    required String advertiseMsgType
  }) {
    if (!_connected) {
      log('$_logPrefix Publish ignored, not connected', name: 'WS');
      return;
    }

    if (!_publishedTopics.contains(topic)) {
      final advMsg = _advertiseMessage(topic, advertiseMsgType);
      _channel.sink.add(advMsg);
      _publishedTopics.add(topic);
    }

    final data = _buildMessage('publish', topic, message);

    log('$_logPrefix Publishing to [$topic] -> $message', name: 'WS');

    _channel.sink.add(data);
  }

  Stream<DataMap> subscribe({required String topic}) {
    if (!_connected) {
      log('$_logPrefix Subscribe failed, not connected', name: 'WS');

      throw const WebSocketException(
        message: 'WebSocket not connected',
        statusCode: 404,
      );
    }

    final controller = _topicControllers.putIfAbsent(
      topic,
      () {
        log('$_logPrefix Subscribing to topic [$topic]', name: 'WS');

        final c = StreamController<DataMap>.broadcast(
          onCancel: () => unsubscribe(topic: topic),
        );

        _subscribedTopics.add(topic);

        final data = _buildMessage('subscribe', topic);
        _channel.sink.add(data);

        return c;
      },
    );

    return controller.stream;
  }

  Future<void> unsubscribe({required String topic}) async {
    log('$_logPrefix Unsubscribing from [$topic]', name: 'WS');

    if (!_connected) {
      log('$_logPrefix Cannot unsubscribe, not connected', name: 'WS');
      return;
    }

    try {
      _channel.sink.add(_buildMessage('unsubscribe', topic));
    } on Exception catch (e) {
      log('$_logPrefix Unsubscribe error: $e', name: 'WS');
    }

    await _topicControllers[topic]?.close();
    _topicControllers.remove(topic);
    _subscribedTopics.remove(topic);
  }

  void _handleMessage(dynamic message) {
    log('$_logPrefix Raw message received -> $message', name: 'WS');

    try {
      final decoded = jsonDecode(message.toString()) as DataMap;

      final topic = decoded['topic'] as String?;
      final msg = decoded['msg'] as DataMap?;

      if (topic == null || msg == null) {
        log('$_logPrefix Invalid message format', name: 'WS');
        return;
      }

      if (_topicControllers.containsKey(topic)) {
        log('$_logPrefix Message for [$topic] -> $msg', name: 'WS');

        _topicControllers[topic]!.add(msg);
      } else {
        log('$_logPrefix No subscribers for topic [$topic]', name: 'WS');
      }
    } on Exception catch (e, stack) {
      log(
        '$_logPrefix Message parsing failed',
        name: 'WS',
        error: e,
        stackTrace: stack,
      );
    }
  }

  String _buildMessage(String op, String topic, [DataMap? msg]) {
    return jsonEncode({
      'op': op,
      'topic': topic,
      'msg': ?msg,
    });
  }

  String _advertiseMessage(String topic, String messageType) {
    return jsonEncode({
      'op': 'advertise',
      'topic': topic,
      'type': messageType
    });
  }

  void _handleDisconnect() {
    if (!_connected) return;

    log('$_logPrefix Disconnected from server', name: 'WS');

    _connected = false;
    _connectionController.add(WebSocketState.disconnected);
    _publishedTopics.clear();

    if (!_manuallyDisconnected) {
      log('$_logPrefix Scheduling reconnect...', name: 'WS');
      _scheduleReconnect();
    }
  }

  void _scheduleReconnect() {
    _reconnectTimer?.cancel();
    if (_connected || _manuallyDisconnected) return;

    log(
      '$_logPrefix Reconnect scheduled every ${_reconnectInterval.inSeconds}s',
      name: 'WS',
    );

    _reconnectTimer = Timer.periodic(_reconnectInterval, (_) async {
      if (_connected || _manuallyDisconnected) return;

      log('$_logPrefix Attempting reconnect...', name: 'WS');

      try {
        await connect();
        log('$_logPrefix Reconnect successful', name: 'WS');
        _resubscribeTopics();
        _reconnectTimer?.cancel();
      } on Exception catch (e) {
        log('$_logPrefix Reconnect failed: $e', name: 'WS');
      }
    });
  }

  void _resubscribeTopics() {
    for (final topic in _subscribedTopics) {
      try {
        final data = _buildMessage('subscribe', topic);
        _channel.sink.add(data);

        log('$_logPrefix Resubscribed to [$topic]', name: 'WS');
      } on Exception catch (e) {
        log('$_logPrefix Failed to resubscribe [$topic]: $e', name: 'WS');
      }
    }
  }

  Future<void> _clearConnection() async {
    log('$_logPrefix Clearing connection state', name: 'WS');

    _connected = false;
    _connectionController.add(WebSocketState.disconnected);

    for (final controller in _topicControllers.values) {
      await controller.close();
    }

    _topicControllers.clear();
    _subscribedTopics.clear();
    _publishedTopics.clear();

    _reconnectTimer?.cancel();
  }
}
