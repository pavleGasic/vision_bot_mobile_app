import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:vision_bot_mobile_app/core/resources/media/media_resources.dart';

class RobotModelView extends StatelessWidget {
  const RobotModelView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 250),
          child: ModelViewer(
            src: MediaResources.ringGlb,
            cameraControls: false,
            autoRotate: true,
            autoRotateDelay: 2,
            rotationPerSecond: '10deg',
          ),
        ),
        ModelViewer(
          src: MediaResources.robotGlb,
          autoRotate: false,
          minCameraOrbit: 'auto 70deg auto',
          maxCameraOrbit: 'auto 110deg auto',
        ),
      ],
    );
  }
}
