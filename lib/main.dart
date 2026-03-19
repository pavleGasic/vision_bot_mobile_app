import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:vision_bot_mobile_app/core/di/service_locator.dart';
import 'package:vision_bot_mobile_app/core/resources/theme/app_theme.dart';
import 'package:vision_bot_mobile_app/core/services/routing/router.dart';
import 'package:vision_bot_mobile_app/core/services/websocket/web_socket_client.dart';
import 'package:vision_bot_mobile_app/src/presentation/home/providers/home_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => HomeController())],
      child: MaterialApp(
        title: 'VisionBot',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        onGenerateRoute: generateRoute,
      ),
    );
  }
}
