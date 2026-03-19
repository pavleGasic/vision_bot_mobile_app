import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:vision_bot_mobile_app/core/resources/colors/color_palette.dart';

class JoystickControl extends StatelessWidget {
  const JoystickControl({
    required this.isEnabled,
    required this.handleMove,
    super.key,
  });

  final bool isEnabled;
  final void Function(StickDragDetails) handleMove;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isEnabled ? 1 : 0.4,
      child: IgnorePointer(
        ignoring: !isEnabled,
        child: Joystick(
          listener: handleMove,
          period: const Duration(milliseconds: 500),
          base: JoystickBase(
            decoration: JoystickBaseDecoration(
              color: Theme.of(context).cardColor,
            ),
            arrowsDecoration: JoystickArrowsDecoration(
              color: ColorPalette.primaryColor,
            ),
          ),
          stick: JoystickStick(
            decoration: JoystickStickDecoration(
              color: Theme.of(context).primaryColor,
              shadowColor: Theme.of(context).primaryColor.withAlpha(50),
            ),
          ),
        ),
      ),
    );
  }
}
