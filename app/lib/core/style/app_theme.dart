import 'package:flutter/material.dart';
import 'package:glina/core/style/app_theme_extensions.dart';
import 'package:glina/core/style/palette.dart';

/// Application [ThemeData] — dark glassmorphism.
ThemeData buildAppTheme() {
  const colorScheme = ColorScheme.dark(
    onSurface: Palette.textPrimary,
    primary: Palette.ember,
    onPrimary: Palette.voidBlack,
    secondary: Palette.clayGlow,
  );

  return ThemeData(
    brightness: Brightness.dark,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: Colors.transparent,
    fontFamily: 'Roboto',
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: Palette.textPrimary,
        fontSize: 32,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.5,
      ),
      headlineSmall: TextStyle(
        color: Palette.textPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.3,
      ),
      bodyLarge: TextStyle(
        color: Palette.textSecondary,
        fontSize: 16,
        height: 1.45,
      ),
      labelLarge: TextStyle(
        color: Palette.textPrimary,
        fontSize: 13,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.4,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: Palette.textPrimary,
      elevation: 0,
      centerTitle: false,
      scrolledUnderElevation: 0,
    ),
    extensions: const [glassThemeExtension, ambientThemeExtension],
    useMaterial3: true,
  );
}
