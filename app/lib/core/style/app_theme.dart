import 'package:flutter/material.dart';
import 'package:glina/core/style/palette.dart';

/// Application [ThemeData] built from design tokens.
ThemeData buildAppTheme() {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: Palette.clay,
    primary: Palette.clay,
    onPrimary: Colors.white,
    surface: Palette.cream,
    onSurface: Palette.ink,
  );

  return ThemeData(
    colorScheme: colorScheme,
    scaffoldBackgroundColor: Palette.cream,
    appBarTheme: const AppBarTheme(
      backgroundColor: Palette.cream,
      foregroundColor: Palette.ink,
      elevation: 0,
      centerTitle: true,
    ),
    useMaterial3: true,
  );
}
