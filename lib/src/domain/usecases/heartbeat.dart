import 'package:vision_bot_mobile_app/core/utils/typedefs.dart';
import 'package:vision_bot_mobile_app/core/utils/usecase_utils.dart';
import 'package:vision_bot_mobile_app/src/domain/entities/heartbeat_message.dart';
import 'package:vision_bot_mobile_app/src/domain/repos/robot_repo.dart';

class Heartbeat extends UsecaseWithoutParams<Stream<HeartbeatMessage>> {
  const Heartbeat(this._repo);

  final RobotRepo _repo;

  @override
  ResultObject<Stream<HeartbeatMessage>> call() => _repo.subscribeHeartbeat();
}
