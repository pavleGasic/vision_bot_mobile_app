import 'package:equatable/equatable.dart';

class VelocityCommand extends Equatable {
  const VelocityCommand({
    required this.angularZ,
    required this.linearX,
  });

  final double linearX;
  final double angularZ;

  @override
  List<Object?> get props => [angularZ, linearX];
}
