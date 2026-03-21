import 'package:vision_bot_mobile_app/core/utils/typedefs.dart';
import 'package:vision_bot_mobile_app/core/utils/usecase_utils.dart';
import 'package:vision_bot_mobile_app/src/domain/entities/camera_data.dart';
import 'package:vision_bot_mobile_app/src/domain/repos/robot_repo.dart';

class SubscribeCamera extends UsecaseWithoutParams<Stream<CameraData>> {
  const SubscribeCamera(this._repo);

  final RobotRepo _repo;

  @override
  ResultObject<Stream<CameraData>> call() => _repo.subscribeCamera();
}
