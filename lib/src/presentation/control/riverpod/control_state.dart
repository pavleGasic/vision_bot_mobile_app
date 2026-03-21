import 'package:equatable/equatable.dart';
import 'package:vision_bot_mobile_app/src/domain/entities/twist.dart';

sealed class ControlState extends Equatable {
  const ControlState();

  @override
  List<Object?> get props => [];
}

final class ControlInitial extends ControlState {
  const ControlInitial();
}

final class ControlSendSuccess extends ControlState {
  const ControlSendSuccess(this.twist);

  final Twist twist;

  @override
  List<Object?> get props => [twist];
}

final class ControlSendFail extends ControlState {
  const ControlSendFail(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
