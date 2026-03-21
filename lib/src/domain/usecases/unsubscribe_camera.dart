import 'package:vision_bot_mobile_app/core/utils/typedefs.dart';
import 'package:vision_bot_mobile_app/core/utils/usecase_utils.dart';
import 'package:vision_bot_mobile_app/src/domain/repos/robot_repo.dart';

class UnsubscribeCamera extends UsecaseWithoutParams<void> {
  const UnsubscribeCamera(this._repo);

  final RobotRepo _repo;

  @override
  ResultObject<void> call() => _repo.unsubscribeCamera();
}
