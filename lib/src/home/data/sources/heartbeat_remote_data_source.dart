import 'package:vision_bot_mobile_app/src/home/data/models/heartbeat_message_model.dart';

abstract class HeartbeatRemoteDataSource {
  const HeartbeatRemoteDataSource();

  Stream<HeartbeatMessageModel> subscribeHeartbeat();
}
