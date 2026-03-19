import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vision_bot_mobile_app/core/di/service_locator.dart';
import 'package:vision_bot_mobile_app/src/domain/entities/heartbeat_message.dart';
import 'package:vision_bot_mobile_app/src/domain/entities/ros_connection_state.dart';
import 'package:vision_bot_mobile_app/src/domain/usecases/heartbeat.dart';
import 'package:vision_bot_mobile_app/src/domain/usecases/ros_connect.dart';

part 'home_adapter.g.dart';
part 'home_state.dart';

@riverpod
class HomeAdapter extends _$HomeAdapter {
  @override
  HomeState build([GlobalKey? familyKey]) {
    return const HomeInitial();
  }

  final Heartbeat _heartbeat = serviceLocator<Heartbeat>();
  final RosConnect _rosConnect = serviceLocator<RosConnect>();
  StreamSubscription<RosConnectionState>? _connectionSub;

  void connectRobot() {
    state = const ConnectionLoading();
    final result = _rosConnect();
    return result.fold(
      (failure) => state = ConnectionFailed(failure.message),
      (connStateStream) async {
        await _connectionSub?.cancel();

        _connectionSub = connStateStream.listen((connState) {
          switch (connState) {
            case RosConnectionState.loading:
              state = const ConnectionLoading();

            case RosConnectionState.connected:
              subscribeHeartbeat();

            case RosConnectionState.disconnected:
              state = const ConnectionDisconnected('Robot disconnected');

            case RosConnectionState.failed:
              state = const ConnectionFailed('Connection failed');
          }
        });
      },
    );
  }

  void subscribeHeartbeat() {
    final result = _heartbeat();
    return result.fold(
      (failure) => state = ConnectionFailed(failure.message),
      (hbMsg) => state = ConnectionSucceed(hbMsg),
    );
  }
}
