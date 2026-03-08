import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:vision_bot_mobile_app/core/resources/colors/color_palette.dart';

class JoystickControl extends StatelessWidget {
  const JoystickControl({super.key});

  @override
  Widget build(BuildContext context) {
    return Joystick(
      listener: (details) {},
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
    );
  }
}
