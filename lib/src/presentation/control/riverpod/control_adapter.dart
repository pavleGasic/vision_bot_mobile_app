import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vision_bot_mobile_app/core/di/service_locator.dart';
import 'package:vision_bot_mobile_app/src/domain/entities/twist.dart';
import 'package:vision_bot_mobile_app/src/domain/usecases/publish_velocity.dart';
import 'package:vision_bot_mobile_app/src/presentation/control/riverpod/control_state.dart';

part 'control_adapter.g.dart';

@riverpod
class ControlAdapter extends _$ControlAdapter {
  @override
  ControlState build([GlobalKey? familyKey]) {
    return const ControlInitial();
  }

  final PublishVelocity _publishVelocity = serviceLocator<PublishVelocity>();

  void publishVelocity(Twist twist) {
    final param = VelocityCommandParams(
      angular: twist.angular,
      linear: twist.linear,
    );
    final result = _publishVelocity(param);
    return result.fold(
      (failure) => state = const ControlSendSuccess(),
      (hbMsg) =>
          state = const ControlSendFail('Error while sending velocity message'),
    );
  }
}
