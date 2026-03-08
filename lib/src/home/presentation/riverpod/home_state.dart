part of 'home_adapter.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

final class HomeInitial extends HomeState {
  const HomeInitial();
}

final class ConnectionLoading extends HomeState {
  const ConnectionLoading();
}

final class ConnectionSucceed extends HomeState {
  const ConnectionSucceed(this.heartbeatMessage);

  final Stream<HeartbeatMessage> heartbeatMessage;

  @override
  List<Object?> get props => [heartbeatMessage];
}

final class ConnectionFailed extends HomeState {
  const ConnectionFailed(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
