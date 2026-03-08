import 'package:vision_bot_mobile_app/core/utils/typedefs.dart';
import 'package:vision_bot_mobile_app/src/control/domain/entities/velocity_command.dart';

abstract class VelocityRepo {
  const VelocityRepo();

  ResultObject<VelocityCommand> sendVelocity({
    required double angularZ,
    required double linearX,
  });
}
