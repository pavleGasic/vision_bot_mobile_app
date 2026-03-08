import 'dart:async';
import 'dart:convert';

import 'package:vision_bot_mobile_app/core/errors/exceptions.dart';
import 'package:vision_bot_mobile_app/core/utils/typedefs.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketClient {
  WebSocketClient({
    required String uri,
  }) {
    _connect(uri);
  }

  late WebSocketChannel _channel;
  bool _connected = false;
  final Map<String, StreamController<DataMap>> _topicControllers = {};

  bool get isConnected => _connected;

  Future<void> disconnect() async {
    await _channel.sink.close();
    _connected = false;

    for (final controller in _topicControllers.values) {
      await controller.close();
    }

    _topicControllers.clear();
  }

  void _connect(String uri) {
    try {
      _channel = WebSocketChannel.connect(Uri.parse(uri));

      _channel.stream.listen(
        _handleMessage,
        onError: (error) {
          _connected = false;
        },
        onDone: () {
          _connected = false;
        },
      );

      _connected = true;
    } catch (e) {
      _connected = false;
      throw WebSocketException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }

  void publish({
    required String topic,
    required DataMap message,
  }) {
    if (!_connected) return;

    final data = {'op': 'publish', 'topic': topic, 'msg': message};

    _channel.sink.add(data);
  }

  Stream<DataMap> subscribe({required String topic}) {
    if (!_connected) {
      throw const WebSocketException(
        message: 'WebSocket not connected',
        statusCode: 404,
      );
    }

    final controller = _topicControllers.putIfAbsent(
      topic,
      () {
        final c = StreamController<DataMap>.broadcast();

        final data = {
          'op': 'subscribe',
          'topic': topic,
        };

        _channel.sink.add(jsonEncode(data));

        return c;
      },
    );

    return controller.stream;
  }

  Future<void> unsubscribe({required String topic}) async {
    if (!_connected) return;

    final data = {
      'op': 'unsubscribe',
      'topic': topic,
    };

    _channel.sink.add(data);
    await _topicControllers[topic]?.close();
    _topicControllers.remove(topic);
  }

  void _handleMessage(dynamic message) {
    final decoded = jsonDecode(message.toString()) as DataMap;
    final topic = decoded['topic'] as String?;
    final msg = decoded['msg'] as DataMap?;

    if (topic == null || msg == null) return;

    if (_topicControllers.containsKey(topic)) {
      _topicControllers[topic]!.add(
        DataMap.from(msg),
      );
    }
  }
}
