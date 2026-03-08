import 'package:flutter/material.dart';
import 'package:vision_bot_mobile_app/core/common/widgets/rounded_container.dart';
import 'package:vision_bot_mobile_app/core/resources/colors/color_palette.dart';
import 'package:vision_bot_mobile_app/src/control/presentation/widget/joystick_control.dart';

class ControlView extends StatelessWidget {
  const ControlView({super.key});

  @override
  Widget build(BuildContext context) {
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
                const JoystickControl(),
                RoundedContainer(
                  height: 63,
                  width: 200,
                  child: Column(
                    children: [
                      Text(
                        'MOVE LEFT/RIGHT',
                        style: Theme.of(
                          context,
                        ).textTheme.labelSmall?.copyWith(fontSize: 14),
                      ),
                      Text(
                        '0.0 / 0.0',
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: ColorPalette.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40,)
        ],
      ),
    );
  }
}
