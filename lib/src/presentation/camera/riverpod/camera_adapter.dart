import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vision_bot_mobile_app/core/di/service_locator.dart';
import 'package:vision_bot_mobile_app/src/domain/usecases/subscribe_camera.dart';
import 'package:vision_bot_mobile_app/src/domain/usecases/unsubscribe_camera.dart';
import 'package:vision_bot_mobile_app/src/presentation/camera/riverpod/camera_state.dart';

part 'camera_adapter.g.dart';

@riverpod
class CameraAdapter extends _$CameraAdapter {
  @override
  CameraState build([GlobalKey? familyKey]) {
    return const CameraInitial();
  }

  final SubscribeCamera _subscribeCamera = serviceLocator<SubscribeCamera>();
  final UnsubscribeCamera _unsubscribeCamera =
      serviceLocator<UnsubscribeCamera>();

  void subscribeCamera() {
    final result = _subscribeCamera();

    return result.fold(
      (failure) => state = CameraSubscribeFail(failure.errorMessage),
      (cameraData) => state = CameraSubscribed(cameraData),
    );
  }

  void unsubscribeCamera() {
    final result = _unsubscribeCamera();

    return result.fold(
      (failure) => state = CameraSubscribeFail(failure.errorMessage),
      (_) => state = const CameraInitial(),
    );
  }
}
