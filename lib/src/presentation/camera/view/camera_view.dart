import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as provider;
import 'package:vision_bot_mobile_app/core/common/widgets/empty_icon_message.dart';
import 'package:vision_bot_mobile_app/core/resources/colors/color_palette.dart';
import 'package:vision_bot_mobile_app/core/resources/consts/icon_consts.dart';
import 'package:vision_bot_mobile_app/src/presentation/camera/riverpod/camera_adapter.dart';
import 'package:vision_bot_mobile_app/src/presentation/camera/riverpod/camera_state.dart';
import 'package:vision_bot_mobile_app/src/presentation/home/providers/home_controller.dart';

class CameraView extends ConsumerStatefulWidget {
  const CameraView({super.key});

  @override
  ConsumerState<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends ConsumerState<CameraView> {
  Stream<Uint8List>? _imageStream;
  bool _displayCamera = false;
  bool _subscribed = false;

  void _onTabChanged() {
    final homeController = context.read<HomeController>();

    final isActive = homeController.currentIndex == 2;

    if (isActive && !_subscribed) {
      _subscribed = true;
      ref.read(cameraAdapterProvider().notifier).subscribeCamera();
    }

    if (!isActive && _subscribed) {
      _subscribed = false;
      ref.read(cameraAdapterProvider().notifier).unsubscribeCamera();
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<HomeController>().addListener(_onTabChanged);
  }

  @override
  void dispose() {
    context.read<HomeController>().removeListener(_onTabChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(cameraAdapterProvider(), (prev, next) {
      if (next is CameraSubscribed) {
        _displayCamera = true;
        setState(() {
          _imageStream = next.cameraData.map(
            (e) => e.data,
          );
        });
      } else if (next is CameraSubscribeFail || next is CameraInitial) {
        setState(() {
          _displayCamera = false;
        });
      }
    });

    return Center(
      child: RotatedBox(
        quarterTurns: 1,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              'Camera Feed',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            Text(
              "live view from robot's camera",
              style: Theme.of(context).textTheme.labelSmall,
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).primaryColorDark,
                ),
                child: !_displayCamera
                    ? EmptyIconMessage(
                        icon: IconConsts.cameraError,
                        message: 'Camera error',
                      )
                    : StreamBuilder<Uint8List>(
                        stream: _imageStream,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const CircularProgressIndicator(
                              color: ColorPalette.backgroundColor,
                            );
                          }
                          return Image.memory(
                            snapshot.data!,
                            gaplessPlayback: true,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
