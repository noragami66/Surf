import 'package:flutter/material.dart';

/// Dark glassmorphism palette for «Глина».
abstract final class Palette {
  static const Color voidBlack = Color(0xFF050505);
  static const Color surface = Color(0xFF121212);
  static const Color surfaceElevated = Color(0xFF1A1A1A);

  static const Color textPrimary = Color(0xFFF5F5F5);
  static const Color textSecondary = Color(0xFF9A9A9A);
  static const Color textMuted = Color(0xFF6B6B6B);

  /// Pottery ember accent (warm gradient anchor).
  static const Color ember = Color(0xFFE87A45);
  static const Color emberDeep = Color(0xFFB84E28);
  static const Color clayGlow = Color(0xFF8B5A3C);

  static const Color glassFill = Color(0x14FFFFFF);
  static const Color glassBorder = Color(0x24FFFFFF);
  static const Color glassHighlight = Color(0x33FFFFFF);
}
