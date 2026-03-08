import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vision_bot_mobile_app/core/di/service_locator.dart';
import 'package:vision_bot_mobile_app/src/home/domain/entities/heartbeat_message.dart';
import 'package:vision_bot_mobile_app/src/home/domain/usecases/heartbeat.dart';

part 'home_adapter.g.dart';

part 'home_state.dart';

@riverpod
class HomeAdapter extends _$HomeAdapter {
  @override
  HomeState build([GlobalKey? familyKey]) {
    return const HomeInitial();
  }

  final Heartbeat _heartbeat = serviceLocator<Heartbeat>();

  void subscribeHeartbeat() {
    state = const ConnectionLoading();
    final result = _heartbeat();
    return result.fold(
      (failure) => state = ConnectionFailed(failure.message),
      (hbMsg) => state = ConnectionSucceed(hbMsg),
    );
  }
}
