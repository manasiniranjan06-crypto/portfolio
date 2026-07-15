import 'package:flutter/material.dart';
import 'package:portfolio/theme/darkColor.dart';
import 'package:portfolio/theme/lightColor.dart';

/// Carries palette fields that don't have a slot in Flutter's built-in
/// ThemeData/ColorScheme (tagBg, navBg, sectionLabel, etc). Access via
/// `Theme.of(context).extension<AppColorsExt>()!` from any section file
/// instead of importing DarkColors/LightColors directly -- that direct
/// import is what breaks the light/dark toggle, since a section that
/// hardcodes DarkColors.x will never change when the theme switches.
@immutable
class AppColorsExt extends ThemeExtension<AppColorsExt> {
  final Color cardBg;
  final Color navBg;
  final Color accentGlow;
  final Color textMuted;
  final Color tagBg;
  final Color sectionLabel;

  const AppColorsExt({
    required this.cardBg,
    required this.navBg,
    required this.accentGlow,
    required this.textMuted,
    required this.tagBg,
    required this.sectionLabel,
  });

  @override
  AppColorsExt copyWith({
    Color? cardBg,
    Color? navBg,
    Color? accentGlow,
    Color? textMuted,
    Color? tagBg,
    Color? sectionLabel,
  }) {
    return AppColorsExt(
      cardBg: cardBg ?? this.cardBg,
      navBg: navBg ?? this.navBg,
      accentGlow: accentGlow ?? this.accentGlow,
      textMuted: textMuted ?? this.textMuted,
      tagBg: tagBg ?? this.tagBg,
      sectionLabel: sectionLabel ?? this.sectionLabel,
    );
  }

  @override
  AppColorsExt lerp(ThemeExtension<AppColorsExt>? other, double t) {
    if (other is! AppColorsExt) return this;
    return AppColorsExt(
      cardBg: Color.lerp(cardBg, other.cardBg, t)!,
      navBg: Color.lerp(navBg, other.navBg, t)!,
      accentGlow: Color.lerp(accentGlow, other.accentGlow, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      tagBg: Color.lerp(tagBg, other.tagBg, t)!,
      sectionLabel: Color.lerp(sectionLabel, other.sectionLabel, t)!,
    );
  }
}

/// Convenience getter: `context.colors.tagBg` instead of the long form.
extension AppColorsContext on BuildContext {
  AppColorsExt get colors => Theme.of(this).extension<AppColorsExt>()!;
}

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
      bodyLarge: TextStyle(color: LightColors.textPrimary, fontSize: 18),
      bodyMedium: TextStyle(color: LightColors.textSecondary, fontSize: 15),
      titleLarge: TextStyle(
        color: LightColors.textPrimary,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
    extensions: const [
      AppColorsExt(
        cardBg: LightColors.cardBg,
        navBg: LightColors.navBg,
        accentGlow: LightColors.accentGlow,
        textMuted: LightColors.textMuted,
        tagBg: LightColors.tagBg,
        sectionLabel: LightColors.sectionLabel,
      ),
    ],
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
      bodyLarge: TextStyle(color: DarkColors.textPrimary, fontSize: 18),
      bodyMedium: TextStyle(color: DarkColors.textSecondary, fontSize: 15),
      titleLarge: TextStyle(
        color: DarkColors.textPrimary,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
    extensions: const [
      AppColorsExt(
        cardBg: DarkColors.cardBg,
        navBg: DarkColors.navBg,
        accentGlow: DarkColors.accentGlow,
        textMuted: DarkColors.textMuted,
        tagBg: DarkColors.tagBg,
        sectionLabel: DarkColors.sectionLabel,
      ),
    ],
  );
}