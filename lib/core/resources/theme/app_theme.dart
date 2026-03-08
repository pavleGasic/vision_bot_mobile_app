import 'package:flutter/material.dart';
import 'package:vision_bot_mobile_app/core/resources/colors/color_palette.dart';
import 'package:vision_bot_mobile_app/core/resources/styles/text_styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    //colors
    primaryColor: ColorPalette.primaryColor,
    scaffoldBackgroundColor: ColorPalette.backgroundColor,
    highlightColor: Colors.white,
    primaryColorDark: ColorPalette.primaryColorDark,
    cardColor: ColorPalette.cardColor,
    fontFamily: 'UbuntuMono',
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: ColorPalette.backgroundColor
    ),
    //text theme
    textTheme: TextStyles.textTheme,
    //icons
    iconTheme: const IconThemeData(
      color: ColorPalette.primaryColor,
      size: 32,
    ),
    //text selection on text field
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: ColorPalette.primaryColor,
      selectionColor: ColorPalette.primaryColor.withValues(alpha: 0.2),
      selectionHandleColor: ColorPalette.primaryColor,
    ),
  );
}
