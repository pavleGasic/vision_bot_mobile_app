import 'dart:async';
import 'dart:developer';

import 'package:vision_bot_mobile_app/core/errors/exceptions.dart';
import 'package:vision_bot_mobile_app/core/services/websocket/web_socket_state.dart';
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
  late StreamSubscription<dynamic> _subscription;

  void Function(dynamic)? _onData;
  void Function()? _onReconnect;

  bool _connected = false;
  bool _manuallyDisconnected = false;
  Timer? _reconnectTimer;

  final StreamController<WebSocketState> _connectionController =
      StreamController<WebSocketState>.broadcast();

  StreamController<WebSocketState> get streamController =>
      _connectionController;

  static const _logPrefix = '[WebSocketClient]';

  Future<void> connect(
    void Function(dynamic)? onData, {
    void Function()? onError,
    void Function()? onDone,
    void Function()? onReconnect,
  }) async {
    _onData = onData;
    _onReconnect = onReconnect;
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
        onData,
        onError: (dynamic error) {
          log('$_logPrefix Stream error: $error', name: 'WS', error: error);
          _handleDisconnect();
          onError?.call();
        },
        onDone: () {
          log('$_logPrefix Connection closed by server', name: 'WS');
          _handleDisconnect();
          onDone?.call();
        },
      );

      _connected = true;
      _manuallyDisconnected = false;
      _connectionController.add(WebSocketState.connected);
      _reconnectTimer?.cancel();
      log('$_logPrefix Connected successfully', name: 'WS');
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
      await _subscription.cancel();
      await _channel.sink.close();
    } on Exception catch (e) {
      log('$_logPrefix Error while disconnecting: $e', name: 'WS');
    }

    _connectionController.add(WebSocketState.disconnected);
    log('$_logPrefix Disconnected', name: 'WS');
  }

  void publish({
    required String message,
  }) {
    if (!_connected) {
      log('$_logPrefix Publish ignored, not connected', name: 'WS');
      return;
    }

    _channel.sink.add(message);
  }

  void subscribe({required String message}) {
    if (!_connected) {
      log('$_logPrefix Subscribe failed, not connected', name: 'WS');

      throw const WebSocketException(
        message: 'WebSocket not connected',
        statusCode: 404,
      );
    }

    _channel.sink.add(message);
  }

  void unsubscribe({required String message}) {
    log('$_logPrefix Unsubscribing from topic.', name: 'WS');
    if (!_connected) {
      log('$_logPrefix Cannot unsubscribe, not connected', name: 'WS');
      return;
    }

    try {
      _channel.sink.add(message);
    } on Exception catch (e) {
      log('$_logPrefix Unsubscribe error: $e', name: 'WS');
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
        await connect(_onData, onReconnect: _onReconnect);
        log('$_logPrefix Reconnect successful', name: 'WS');
        _onReconnect?.call();
        _reconnectTimer?.cancel();
      } on Exception catch (e) {
        log('$_logPrefix Reconnect failed: $e', name: 'WS');
      }
    });
  }

  void _handleDisconnect() {
    if (!_connected) return;

    log('$_logPrefix Disconnected from server', name: 'WS');

    _connected = false;
    _connectionController.add(WebSocketState.disconnected);

    if (!_manuallyDisconnected) {
      log('$_logPrefix Scheduling reconnect...', name: 'WS');
      _scheduleReconnect();
    }
  }
}
