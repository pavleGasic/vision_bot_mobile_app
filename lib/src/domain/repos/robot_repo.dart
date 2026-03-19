import 'package:vector_math/vector_math.dart';
import 'package:vision_bot_mobile_app/core/utils/typedefs.dart';
import 'package:vision_bot_mobile_app/src/domain/entities/heartbeat_message.dart';
import 'package:vision_bot_mobile_app/src/domain/entities/ros_connection_state.dart';
import 'package:vision_bot_mobile_app/src/domain/entities/twist.dart';

abstract class RobotRepo {
  const RobotRepo();

  ResultObject<Stream<RosConnectionState>> rosConnect();

  ResultObject<Stream<HeartbeatMessage>> subscribeHeartbeat();

  ResultObject<Twist> publishVelocity({
    required Vector3 angular,
    required Vector3 linear,
  });
}
