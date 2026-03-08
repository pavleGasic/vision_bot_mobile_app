import 'package:vision_bot_mobile_app/core/errors/exceptions.dart';
import 'package:vision_bot_mobile_app/core/services/websocket/web_socket_client.dart';
import 'package:vision_bot_mobile_app/src/home/data/models/heartbeat_message_model.dart';
import 'package:vision_bot_mobile_app/src/home/data/sources/heartbeat_remote_data_source.dart';

class HeartbeatRemoteDataSourceImpl implements HeartbeatRemoteDataSource {
  HeartbeatRemoteDataSourceImpl({required this.wsClient});

  final WebSocketClient wsClient;

  final String heartbeatTopic = '/heartbeat';

  @override
  Stream<HeartbeatMessageModel> subscribeHeartbeat() {
    try {
      return wsClient
          .subscribe(topic: heartbeatTopic)
          .map(HeartbeatMessageModel.fromMap);
    } on WebSocketException catch (_) {
      rethrow;
    } on Exception catch (_) {
      throw const WebSocketException(
        message: 'WebSocket not connected',
        statusCode: 404,
      );
    }
  }
}
