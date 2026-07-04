import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:glina/core/style/app_theme_extensions.dart';
import 'package:glina/core/style/palette.dart';

/// Multi-tone green/blue mesh gradient with heavy blur.
class AmbientBackground extends StatelessWidget {
  const AmbientBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final ambient = AmbientThemeExtension.of(context);
    final screen = MediaQuery.sizeOf(context);

    return ColoredBox(
      color: Palette.voidBlack,
      child: Stack(
        fit: StackFit.expand,
        children: [
          _orb(
            top: screen.height * 0.08,
            left: -ambient.primaryOrbSize * 0.5,
            size: ambient.primaryOrbSize,
            color: Palette.emeraldGlow,
            opacity: ambient.primaryOpacity,
            blur: ambient.glowBlurSigma,
          ),
          _orb(
            top: -ambient.secondaryOrbSize * 0.3,
            left: screen.width * 0.25,
            size: ambient.secondaryOrbSize,
            color: Palette.cyanGlow,
            opacity: ambient.secondaryOpacity * 1.4,
            blur: ambient.glowBlurSigma * 0.95,
          ),
          _orb(
            top: screen.height * 0.35,
            right: -ambient.secondaryOrbSize * 0.45,
            size: ambient.secondaryOrbSize * 0.85,
            color: Palette.blueSoft,
            opacity: ambient.secondaryOpacity,
            blur: ambient.glowBlurSigma * 0.85,
          ),
          _orb(
            bottom: screen.height * 0.05,
            left: screen.width * 0.1,
            size: ambient.secondaryOrbSize * 0.75,
            color: Palette.forestGlow,
            opacity: ambient.tertiaryOpacity * 1.5,
            blur: ambient.glowBlurSigma * 0.8,
          ),
          _orb(
            top: screen.height * 0.55,
            left: screen.width * 0.45,
            size: ambient.secondaryOrbSize * 0.55,
            color: Palette.tealGlow,
            opacity: ambient.tertiaryOpacity,
            blur: ambient.glowBlurSigma * 0.7,
          ),
          _orb(
            top: screen.height * 0.18,
            right: -ambient.secondaryOrbSize * 0.15,
            size: ambient.secondaryOrbSize * 0.6,
            color: Palette.blueDeep,
            opacity: ambient.tertiaryOpacity * 0.9,
            blur: ambient.glowBlurSigma * 0.75,
          ),
        ],
      ),
    );
  }

  Widget _orb({
    required double size,
    required Color color,
    required double opacity,
    required double blur,
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: _GlowOrb(
        size: size,
        colors: [
          color.withValues(alpha: opacity),
          color.withValues(alpha: opacity * 0.35),
          Colors.transparent,
        ],
        blurSigma: blur,
      ),
    );
  }
}

class _GlowOrb extends StatelessWidget {
  const _GlowOrb({
    required this.size,
    required this.colors,
    required this.blurSigma,
  });

  final double size;
  final List<Color> colors;
  final double blurSigma;

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(colors: colors),
        ),
      ),
    );
  }
}
