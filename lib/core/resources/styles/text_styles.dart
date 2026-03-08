import 'package:flutter/material.dart';

class TextStyles {
  TextStyles._();

  static const textTheme = TextTheme(
    //display - Large sized text
    displayLarge: TextStyle(
      decoration: TextDecoration.none,
      fontSize: 57,
      letterSpacing: 0,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    displayMedium: TextStyle(
      decoration: TextDecoration.none,
      fontSize: 45,
      letterSpacing: 0,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    displaySmall: TextStyle(
      decoration: TextDecoration.none,
      letterSpacing: 0,
      fontSize: 36,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
    //headline - Titles and headings
    headlineLarge: TextStyle(
      decoration: TextDecoration.none,
      letterSpacing: 0,
      fontSize: 32,
      fontWeight: FontWeight.w500,
      fontFamily: 'PS2P',
      color: Colors.white,
    ),
    headlineMedium: TextStyle(
      decoration: TextDecoration.none,
      letterSpacing: 0,
      fontSize: 28,
      fontFamily: 'PS2P',
      color: Colors.white,
    ),
    headlineSmall: TextStyle(
      decoration: TextDecoration.none,
      letterSpacing: 0,
      fontSize: 24,
      fontFamily: 'PS2P',
      color: Colors.white,
    ),
    //title - titles of cards, dialogs, and app bars
    titleLarge: TextStyle(
      fontFamily: 'PS2P',
      decoration: TextDecoration.none,
      letterSpacing: 0,
      fontSize: 22,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    titleMedium: TextStyle(
      fontFamily: 'PS2P',
      decoration: TextDecoration.none,
      letterSpacing: 0,
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    titleSmall: TextStyle(
      fontFamily: 'PS2P',
      decoration: TextDecoration.none,
      letterSpacing: 0,
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    //body - main content of app, such as paragraphs,
    // descriptions, or informative text
    bodyLarge: TextStyle(
      decoration: TextDecoration.none,
      letterSpacing: 0,
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    bodyMedium: TextStyle(
      decoration: TextDecoration.none,
      letterSpacing: 0,
      fontSize: 17,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    bodySmall: TextStyle(
      decoration: TextDecoration.none,
      letterSpacing: 0,
      fontSize: 15,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    //label - used for buttons, captions, or small text elements in UI controls
    labelLarge: TextStyle(
      decoration: TextDecoration.none,
      letterSpacing: 0,
      fontSize: 19,
      color: Colors.white,
      fontWeight: FontWeight.w700,
    ),
    labelMedium: TextStyle(
      decoration: TextDecoration.none,
      letterSpacing: 0,
      fontSize: 17,
      color: Colors.white,
      fontWeight: FontWeight.w700,
    ),
    labelSmall: TextStyle(
      decoration: TextDecoration.none,
      letterSpacing: 0,
      fontSize: 11,
      color: Colors.grey,
      fontWeight: FontWeight.w700,
    ),
  );
}
