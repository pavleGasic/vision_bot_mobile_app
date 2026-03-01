import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vision_bot_mobile_app/core/resources/theme/app_theme.dart';
import 'package:vision_bot_mobile_app/core/services/routing/router.dart';
import 'package:vision_bot_mobile_app/src/home/providers/home_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeController())
      ],
      child: MaterialApp(
        title: 'VisionBot',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        onGenerateRoute: generateRoute,
      ),
    );
  }
}
