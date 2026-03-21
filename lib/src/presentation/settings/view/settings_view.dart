import 'package:flutter/material.dart';
import 'package:vision_bot_mobile_app/core/common/widgets/rounded_container.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildRow(String name, String value) {
      return Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(color: Colors.grey),
            ),
            Text(
              value,
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 25,
      ),
      child: RoundedContainer(
        width: double.infinity,
        height: 160,
        child: Column(
          children: [
            const Text('DEVICE INFO'),
            const SizedBox(
              height: 10,
            ),
            buildRow('Model', 'VisionBotV1'),
            buildRow('Firmware', 'v0.0.1'),
            buildRow('Uptime', '00:00'),
          ],
        ),
      ),
    );
  }
}
