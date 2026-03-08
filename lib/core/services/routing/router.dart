import 'package:flutter/material.dart';
import 'package:vision_bot_mobile_app/src/home/presentation/page/home_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  try {
    switch (settings.name) {
      case '/':
        return _pageRouteBuilder((_) => const HomePage(), settings: settings);
      default:
        return _pageRouteBuilder((_) => const HomePage(), settings: settings);
    }
  } on Exception catch (_) {
    return _pageRouteBuilder((_) => const HomePage(), settings: settings);
  }
}

PageRouteBuilder<dynamic> _pageRouteBuilder(
  Widget Function(BuildContext) page, {
  required RouteSettings settings,
}) {
  return PageRouteBuilder(
    settings: settings,
    transitionsBuilder: (_, animation, _, child) =>
        FadeTransition(opacity: animation, child: child),
    pageBuilder: (context, _, _) => page(context),
  );
}
