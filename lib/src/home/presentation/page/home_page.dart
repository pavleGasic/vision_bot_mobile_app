import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vision_bot_mobile_app/core/common/widgets/custom_app_bar.dart';
import 'package:vision_bot_mobile_app/src/home/providers/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (_, controller, __) {
        return Scaffold(
          appBar: CustomAppBar(
            title: Text(
              'VisionBot',
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
          ),
          body: IndexedStack(
            index: controller.currentIndex,
            children: controller.screens,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'home'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.camera),
                label: 'camera'
              )
            ],
          ),
        );
      },
    );
  }
}
