import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as provider;
import 'package:vision_bot_mobile_app/core/common/widgets/app_bottom_navigation_bar.dart';
import 'package:vision_bot_mobile_app/core/common/widgets/color_dot.dart';
import 'package:vision_bot_mobile_app/core/common/widgets/custom_app_bar.dart';
import 'package:vision_bot_mobile_app/core/common/widgets/rounded_container.dart';
import 'package:vision_bot_mobile_app/core/resources/colors/color_palette.dart';
import 'package:vision_bot_mobile_app/core/resources/consts/image_consts.dart';
import 'package:vision_bot_mobile_app/src/presentation/home/providers/home_controller.dart';
import 'package:vision_bot_mobile_app/src/presentation/home/riverpod/home_adapter.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  String connectionState = '';
  Color connectionColor = ColorPalette.warnColor;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeAdapterProvider().notifier).connectRobot();
    });
  }

  Widget _displayTitle() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'VISION-BOT',
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: ColorPalette.primaryColor,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          'command-center',
          style: Theme.of(
            context,
          ).textTheme.labelSmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  List<Widget> _displayActions() {
    return [
      RoundedContainer(
        height: 45,
        child: Row(
          children: [
            ColorDot(
              color: connectionColor,
            ),
            const SizedBox(
              width: 7,
            ),
            Text(
              connectionState,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey,
              ),
            ),
            VerticalDivider(
              indent: 2,
              endIndent: 2,
              color: Colors.grey.withAlpha(70),
              thickness: 2,
            ),
            ImageConsts.batteryImage(),
            const SizedBox(
              width: 7,
            ),
            Text(
              '87%',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(homeAdapterProvider(), (prev, next) {
      if (next is ConnectionSucceed) {
        setState(() {
          connectionState = 'ONLINE';
          connectionColor = ColorPalette.infoColor;
        });
      } else if (next is ConnectionLoading) {
        setState(() {
          connectionState = 'LOADING';
          connectionColor = ColorPalette.warnColor;
        });
      } else if (next is ConnectionFailed) {
        setState(() {
          connectionState = 'FAILED';
          connectionColor = ColorPalette.errorColor;
        });
      }
    });

    return provider.Consumer<HomeController>(
      builder: (_, controller, _) {
        return Scaffold(
          appBar: CustomAppBar(
            title: _displayTitle(),
            actions: _displayActions(),
          ),
          body: IndexedStack(
            index: controller.currentIndex,
            children: controller.screens,
          ),
          bottomNavigationBar: AppBottomNavigationBar(
            controller: controller,
          ),
        );
      },
    );
  }
}
