import 'package:vision_bot_mobile_app/core/utils/typedefs.dart';
import 'package:vision_bot_mobile_app/src/domain/entities/twist.dart';

class TwistModel extends Twist {
  const TwistModel({
    required super.angular,
    required super.linear,
  });

  DataMap toJson() {
    return {
      'linear': {
        'x': linear.x,
        'y': linear.y,
        'z': linear.z,
      },
      'angular': {
        'x': angular.x,
        'y': angular.y,
        'z': angular.z,
      },
    };
  }
}
