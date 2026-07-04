import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:glina/core/style/app_theme_extensions.dart';
import 'package:glina/core/style/palette.dart';

/// Blurred gradient orbs on a void-black canvas.
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
          Positioned(
            top: -ambient.primaryOrbSize * 0.35,
            right: -ambient.primaryOrbSize * 0.25,
            child: _GlowOrb(
              size: ambient.primaryOrbSize,
              colors: [
                ambient.primaryGlow.withValues(alpha: 0.55),
                ambient.primaryGlow.withValues(alpha: 0),
              ],
              blurSigma: ambient.glowBlurSigma,
            ),
          ),
          Positioned(
            bottom: ambient.secondaryOrbSize * 0.15,
            left: -ambient.secondaryOrbSize * 0.35,
            child: _GlowOrb(
              size: ambient.secondaryOrbSize,
              colors: [
                ambient.secondaryGlow.withValues(alpha: 0.4),
                ambient.secondaryGlow.withValues(alpha: 0),
              ],
              blurSigma: ambient.glowBlurSigma * 0.85,
            ),
          ),
          Positioned(
            top: screen.height * 0.42,
            left: screen.width * 0.55,
            child: _GlowOrb(
              size: ambient.secondaryOrbSize * 0.65,
              colors: [
                ambient.primaryGlow.withValues(alpha: 0.18),
                Colors.transparent,
              ],
              blurSigma: ambient.glowBlurSigma * 0.6,
            ),
          ),
        ],
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
      imageFilter: ImageFilter.blur(
        sigmaX: blurSigma,
        sigmaY: blurSigma,
      ),
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
