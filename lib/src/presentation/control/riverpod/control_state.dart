import 'package:equatable/equatable.dart';

sealed class ControlState extends Equatable {
  const ControlState();

  @override
  List<Object?> get props => [];
}

final class ControlInitial extends ControlState {
  const ControlInitial();
}

final class ControlSendSuccess extends ControlState {
  const ControlSendSuccess();
}

final class ControlSendFail extends ControlState {
  const ControlSendFail(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
