import 'dart:developer' show log;

import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vector_math/vector_math.dart';
import 'package:vision_bot_mobile_app/core/common/widgets/rounded_container.dart';
import 'package:vision_bot_mobile_app/core/resources/colors/color_palette.dart';
import 'package:vision_bot_mobile_app/src/domain/entities/twist.dart';
import 'package:vision_bot_mobile_app/src/presentation/camera/riverpod/camera_adapter.dart';
import 'package:vision_bot_mobile_app/src/presentation/control/riverpod/control_adapter.dart';
import 'package:vision_bot_mobile_app/src/presentation/control/riverpod/control_state.dart';
import 'package:vision_bot_mobile_app/src/presentation/control/widget/joystick_control.dart';
import 'package:vision_bot_mobile_app/src/presentation/home/riverpod/home_adapter.dart';

class ControlView extends ConsumerStatefulWidget {
  const ControlView({super.key});

  @override
  ConsumerState<ControlView> createState() => _ControlViewState();
}

class _ControlViewState extends ConsumerState<ControlView> {
  bool joystickEnabled = false;
  String angularZ = '0.0';
  String linearX = '0.0';
  String errorMessage = '';

  void _handleMove(StickDragDetails details) {
    if (joystickEnabled) {
      final twist = Twist(
        angular: Vector3(0, 0, -details.x),
        linear: Vector3(-details.y, 0, 0),
      );
      ref.read(controlAdapterProvider().notifier).publishVelocity(twist);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref
      ..listen(homeAdapterProvider(), (prev, next) {
        log("message");
        if (next is ConnectionSucceed) {
          setState(() {
            joystickEnabled = true;
          });
        } else if (next is ConnectionFailed ||
            next is ConnectionLoading ||
            next is ConnectionDisconnected) {
          setState(() {
            joystickEnabled = false;
          });
        }
      })
      ..listen(controlAdapterProvider(), (prev, next) {
        if (next is ControlSendSuccess) {
          final twist = next.twist;
          setState(() {
            angularZ = twist.angular.z.toStringAsFixed(1);
            linearX = twist.linear.x.toStringAsFixed(1);
          });
        } else if (next is ControlSendFail) {
          setState(() {
            errorMessage = next.message;
            angularZ = 'N/A';
            linearX = 'N/A';
          });
        }
      });

    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            'Control Panel',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Text(
            'use joysticks to navigate the robot',
            style: Theme.of(context).textTheme.labelSmall,
          ),
          const SizedBox(
            height: 150,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                JoystickControl(
                  handleMove: _handleMove,
                  isEnabled: joystickEnabled,
                ),
                Column(
                  children: [
                    RoundedContainer(
                      height: 63,
                      width: 200,
                      child: Column(
                        children: [
                          Text(
                            'LINEAR_X / ANGULAR_Z',
                            style: Theme.of(
                              context,
                            ).textTheme.labelSmall?.copyWith(fontSize: 14),
                          ),
                          Text(
                            '$linearX / $angularZ',
                            style: Theme.of(context).textTheme.labelMedium
                                ?.copyWith(
                                  color: ColorPalette.primaryColor,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      errorMessage,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: ColorPalette.errorColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
