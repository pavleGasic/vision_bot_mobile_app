import 'package:equatable/equatable.dart';
import 'package:vector_math/vector_math.dart';
import 'package:vision_bot_mobile_app/core/utils/typedefs.dart';
import 'package:vision_bot_mobile_app/core/utils/usecase_utils.dart';
import 'package:vision_bot_mobile_app/src/domain/entities/twist.dart';
import 'package:vision_bot_mobile_app/src/domain/repos/robot_repo.dart';

class PublishVelocity extends UsecaseWithParams<Twist, VelocityCommandParams> {
  const PublishVelocity(this._repo);

  final RobotRepo _repo;

  @override
  ResultObject<Twist> call(VelocityCommandParams params) =>
      _repo.publishVelocity(linear: params.linear, angular: params.angular);
}

class VelocityCommandParams extends Equatable {
  const VelocityCommandParams({
    required this.angular,
    required this.linear,
  });

  final Vector3 linear;
  final Vector3 angular;

  @override
  List<Object?> get props => [linear, angular];
}
