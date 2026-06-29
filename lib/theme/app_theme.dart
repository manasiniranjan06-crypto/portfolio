import 'package:flutter/material.dart';
import 'package:portfolio/theme/darkColor.dart';
import 'package:portfolio/theme/lightColor.dart';

class AppTheme {
  // LIGHT THEME
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,

    scaffoldBackgroundColor: LightColors.background,

    cardColor: LightColors.cardBg,

    dividerColor: LightColors.border,

    appBarTheme: const AppBarTheme(
      backgroundColor: LightColors.navBg,
      foregroundColor: LightColors.textPrimary,
      elevation: 0,
    ),

    colorScheme: const ColorScheme.light(
      primary: LightColors.accent,
      secondary: LightColors.green,
    ),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: LightColors.textPrimary,
        fontSize: 18,
      ),

      bodyMedium: TextStyle(
        color: LightColors.textSecondary,
        fontSize: 15,
      ),

      titleLarge: TextStyle(
        color: LightColors.textPrimary,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  // DARK THEME
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,

    scaffoldBackgroundColor: DarkColors.background,

    cardColor: DarkColors.cardBg,

    dividerColor: DarkColors.border,

    appBarTheme: const AppBarTheme(
      backgroundColor: DarkColors.navBg,
      foregroundColor: DarkColors.textPrimary,
      elevation: 0,
    ),

    colorScheme: const ColorScheme.dark(
      primary: DarkColors.accent,
      secondary: DarkColors.green,
    ),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: DarkColors.textPrimary,
        fontSize: 18,
      ),

      bodyMedium: TextStyle(
        color: DarkColors.textSecondary,
        fontSize: 15,
      ),

      titleLarge: TextStyle(
        color: DarkColors.textPrimary,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}