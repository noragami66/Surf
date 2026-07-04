import 'package:flutter/material.dart';

/// Dark glassmorphism palette for «Глина».
abstract final class Palette {
  static const Color voidBlack = Color(0xFF050505);
  static const Color surface = Color(0xFF121212);
  static const Color surfaceElevated = Color(0xFF1A1A1A);
  static const Color cardFill = Color(0xFF0A0A0A);
  static const Color cardBorder = Color(0x2AFFFFFF);

  static const Color textPrimary = Color(0xFFF5F5F5);
  static const Color textSecondary = Color(0xFF9A9A9A);
  static const Color textMuted = Color(0xFF6B6B6B);

  /// Pottery ember accent (warm gradient anchor).
  static const Color ember = Color(0xFFE87A45);
  static const Color emberDeep = Color(0xFFB84E28);
  static const Color clayGlow = Color(0xFF8B5A3C);

  /// Ambient mesh-gradient anchors.
  static const Color tealGlow = Color(0xFF2EC4B6);
  static const Color tealDeep = Color(0xFF14746F);
  static const Color emeraldGlow = Color(0xFF34D399);
  static const Color forestGlow = Color(0xFF059669);
  static const Color cyanGlow = Color(0xFF22D3EE);
  static const Color blueSoft = Color(0xFF60A5FA);
  static const Color blueDeep = Color(0xFF2563EB);
  static const Color slateGlow = Color(0xFF64748B);

  static const Color glassFill = Color(0x12FFFFFF);
  static const Color glassBorder = Color(0x24FFFFFF);
  static const Color glassBorderLight = Color(0x30FFFFFF);
  static const Color glassHighlight = Color(0x33FFFFFF);
  static const Color glassGradientBright = Color(0x16FFFFFF);
  static const Color glassGradientMid = Color(0x0AFFFFFF);
  static const Color glassGradientDim = Color(0x03000000);

  /// Primary CTA — white pill on dark canvas.
  static const Color ctaWhite = Color(0xFFFFFFFF);
  static const Color ctaForeground = Color(0xFF050505);
}
