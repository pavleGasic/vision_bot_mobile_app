import 'package:equatable/equatable.dart';
import 'package:vector_math/vector_math.dart';

class Twist extends Equatable {
  const Twist({
    required this.angular,
    required this.linear,
  });

  final Vector3 linear;
  final Vector3 angular;

  @override
  List<Object?> get props => [angular, linear];
}
