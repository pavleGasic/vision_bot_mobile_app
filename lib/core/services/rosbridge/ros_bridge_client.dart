import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:vision_bot_mobile_app/core/services/websocket/web_socket_client.dart';
import 'package:vision_bot_mobile_app/core/services/websocket/web_socket_state.dart';
import 'package:vision_bot_mobile_app/core/utils/typedefs.dart';

class RosBridgeClient {
  RosBridgeClient({required WebSocketClient webSocketClient})
    : _webSocketClient = webSocketClient;

  final WebSocketClient _webSocketClient;

  final Map<String, StreamController<DataMap>> _topicControllers = {};
  final Set<String> _subscribedTopics = {};
  final Set<String> _publishedTopics = {};
  DateTime _lastFrameTime = DateTime.now();

  StreamController<WebSocketState> get streamController =>
      _webSocketClient.streamController;

  static const _logPrefix = '[RosBridgeClient]';

  Future<void> connect() async {
    await _webSocketClient.connect(
      _handleMessage,
      onReconnect: _resubscribeTopics,
    );
  }

  Future<void> disconnect() async {
    await _webSocketClient.disconnect();
    await _clearConnection();
  }

  void publish({
    required String topic,
    required DataMap message,
    required String advertiseMsgType,
  }) {
    if (!_publishedTopics.contains(topic)) {
      _webSocketClient.publish(
        message: _advertiseMessage(topic, advertiseMsgType),
      );
      _publishedTopics.add(topic);
    }

    log('$_logPrefix Publishing to [$topic] -> $message', name: 'WS');
    final data = _buildMessage('publish', topic, message);
    _webSocketClient.publish(message: data);
  }

  Stream<DataMap> subscribe({required String topic}) {
    if (_subscribedTopics.contains(topic) &&
        _topicControllers.containsKey(topic)) {
      return _topicControllers[topic]!.stream;
    }

    final controller = _topicControllers.putIfAbsent(
      topic,
      () {
        log('$_logPrefix Subscribing to topic [$topic]', name: 'WS');

        final c = StreamController<DataMap>.broadcast();

        _subscribedTopics.add(topic);

        final data = _buildMessage('subscribe', topic);
        _webSocketClient.subscribe(message: data);

        return c;
      },
    );

    return controller.stream;
  }

  void unsubscribe({required String topic}) {
    _webSocketClient.unsubscribe(
      message: _buildMessage('unsubscribe', topic),
    );

    _topicControllers[topic]?.close();
    _topicControllers.remove(topic);
    _subscribedTopics.remove(topic);
  }

  void _handleMessage(dynamic message) {
    final now = DateTime.now();

    if (now.difference(_lastFrameTime).inMilliseconds < 100) {
      return;
    }

    _lastFrameTime = now;

    try {
      final decoded = jsonDecode(message.toString()) as DataMap;

      final topic = decoded['topic'] as String?;
      final msg = decoded['msg'] as DataMap?;

      if (topic == null || msg == null) {
        log('$_logPrefix Invalid message format', name: 'WS');
        return;
      }

      if (_topicControllers.containsKey(topic)) {
        _topicControllers[topic]?.add(msg);
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

  void _resubscribeTopics() {
    for (final topic in _subscribedTopics) {
      try {
        final data = _buildMessage('subscribe', topic);
        _webSocketClient.subscribe(message: data);

        log('$_logPrefix Resubscribed to [$topic]', name: 'WS');
      } on Exception catch (e) {
        log('$_logPrefix Failed to resubscribe [$topic]: $e', name: 'WS');
      }
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
    return jsonEncode({'op': 'advertise', 'topic': topic, 'type': messageType});
  }

  Future<void> _clearConnection() async {
    for (final controller in _topicControllers.values) {
      await controller.close();
    }

    _topicControllers.clear();
    _subscribedTopics.clear();
    _publishedTopics.clear();
  }
}
