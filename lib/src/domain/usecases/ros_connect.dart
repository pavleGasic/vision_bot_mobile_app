import 'package:vision_bot_mobile_app/core/utils/typedefs.dart';
import 'package:vision_bot_mobile_app/core/utils/usecase_utils.dart';
import 'package:vision_bot_mobile_app/src/domain/entities/ros_connection_state.dart';
import 'package:vision_bot_mobile_app/src/domain/repos/robot_repo.dart';

class RosConnect extends UsecaseWithoutParams<Stream<RosConnectionState>> {
  const RosConnect(this._repo);

  final RobotRepo _repo;

  @override
  ResultObject<Stream<RosConnectionState>> call() => _repo.rosConnect();
}
