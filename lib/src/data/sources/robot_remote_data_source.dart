import 'dart:async';

import 'package:vector_math/vector_math.dart';
import 'package:vision_bot_mobile_app/src/data/models/heartbeat_message_model.dart';
import 'package:vision_bot_mobile_app/src/data/models/ros_connection_state_model.dart';

abstract class RobotRemoteDataSource {
  const RobotRemoteDataSource();

  Future<void> connect();

  Stream<RosConnectionStateModel> get connectionStream;

  Stream<HeartbeatMessageModel> subscribeHeartbeat();

  void publishRobotVelocity({
    required Vector3 linear,
    required Vector3 angular,
  });
}
