import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color terracotta = Color(0xFFE07A5F);
  static const Color deepTeal = Color(0xFF2A9D8F);
  static const Color sand = Color(0xFFF4F1DE);
  static const Color ink = Color(0xFF1B263B);
  static const Color slate = Color(0xFF415A77);
  static const Color accentGold = Color(0xFFE9C46A);
  static const Color coralGlow = Color(0xFFFFB5A7);

  static const ColorScheme lightScheme = ColorScheme(
    brightness: Brightness.light,
    primary: terracotta,
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFFFDAD4),
    onPrimaryContainer: Color(0xFF410002),
    secondary: deepTeal,
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFB8EBE3),
    onSecondaryContainer: Color(0xFF00201C),
    tertiary: slate,
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFD4E3FF),
    onTertiaryContainer: Color(0xFF001C3B),
    error: Color(0xFFBA1A1A),
    onError: Color(0xFFFFFFFF),
    surface: sand,
    onSurface: ink,
    onSurfaceVariant: Color(0xFF534742),
    outline: Color(0xFF85736F),
    outlineVariant: Color(0xFFD8C2BC),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    inverseSurface: ink,
    onInverseSurface: sand,
    inversePrimary: coralGlow,
    surfaceContainerHighest: Color(0xFFECE8DD),
    surfaceContainerHigh: Color(0xFFF0EBE0),
    surfaceContainer: Color(0xFFF6F2E8),
    surfaceContainerLow: Color(0xFFFCF8EF),
    surfaceContainerLowest: Color(0xFFFFFFFF),
    surfaceBright: Color(0xFFFFF8F5),
    surfaceDim: Color(0xFFDCD8CE),
  );

  static const ColorScheme darkScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: coralGlow,
    onPrimary: Color(0xFF561E14),
    primaryContainer: Color(0xFF733428),
    onPrimaryContainer: Color(0xFFFFDAD4),
    secondary: Color(0xFF8FD5CB),
    onSecondary: Color(0xFF003731),
    secondaryContainer: Color(0xFF005046),
    onSecondaryContainer: Color(0xFFA8F2E6),
    tertiary: Color(0xFFA8C8FF),
    onTertiary: Color(0xFF003060),
    tertiaryContainer: Color(0xFF1E4878),
    onTertiaryContainer: Color(0xFFD4E3FF),
    error: Color(0xFFFFB4AB),
    onError: Color(0xFF690005),
    surface: Color(0xFF131820),
    onSurface: Color(0xFFE6E1DA),
    onSurfaceVariant: Color(0xFFD8C2BC),
    outline: Color(0xFFA08C87),
    outlineVariant: Color(0xFF534742),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    inverseSurface: sand,
    onInverseSurface: ink,
    inversePrimary: terracotta,
    surfaceContainerHighest: Color(0xFF353945),
    surfaceContainerHigh: Color(0xFF2A2F3A),
    surfaceContainer: Color(0xFF1F252F),
    surfaceContainerLow: Color(0xFF1B2029),
    surfaceContainerLowest: Color(0xFF0D1118),
    surfaceBright: Color(0xFF393F4C),
    surfaceDim: Color(0xFF131820),
  );
}
