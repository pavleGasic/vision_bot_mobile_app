import 'package:equatable/equatable.dart';
import 'package:vision_bot_mobile_app/core/utils/typedefs.dart';
import 'package:vision_bot_mobile_app/core/utils/usecase_utils.dart';
import 'package:vision_bot_mobile_app/src/control/domain/entities/velocity_command.dart';
import 'package:vision_bot_mobile_app/src/control/domain/repos/velocity_repo.dart';

class DriveRobot
    extends UsecaseWithParams<VelocityCommand, VelocityCommandParams> {
  const DriveRobot(this._repo);

  final VelocityRepo _repo;

  @override
  ResultObject<VelocityCommand> call(VelocityCommandParams params) =>
      _repo.sendVelocity(linearX: params.linearX, angularZ: params.angularZ);
}

class VelocityCommandParams extends Equatable {
  const VelocityCommandParams({
    required this.angularZ,
    required this.linearX,
  });

  final double linearX;
  final double angularZ;

  @override
  List<Object?> get props => [linearX, angularZ];
}
