import 'package:equatable/equatable.dart';
import 'package:vision_bot_mobile_app/src/domain/entities/camera_data.dart';

sealed class CameraState extends Equatable {
  const CameraState();

  @override
  List<Object?> get props => [];
}

final class CameraInitial extends CameraState {
  const CameraInitial();
}

final class CameraSubscribed extends CameraState {
  const CameraSubscribed(this.cameraData);

  final Stream<CameraData> cameraData;
}

final class CameraSubscribeFail extends CameraState {
  const CameraSubscribeFail(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

final class CameraLoading extends CameraState {
  const CameraLoading();
}
