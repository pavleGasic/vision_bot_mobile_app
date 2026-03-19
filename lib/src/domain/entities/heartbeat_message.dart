import 'package:equatable/equatable.dart';

class HeartbeatMessage extends Equatable {
  const HeartbeatMessage({
    required this.message,
    required this.isAlive,
  });

  final String message;
  final bool isAlive;

  @override
  List<Object?> get props => [message, isAlive];
}
