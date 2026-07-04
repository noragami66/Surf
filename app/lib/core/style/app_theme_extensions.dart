import 'package:flutter/material.dart';
import 'package:glina/core/style/palette.dart';

@immutable
class GlassThemeExtension extends ThemeExtension<GlassThemeExtension> {
  const GlassThemeExtension({
    required this.blurSigma,
    required this.surfaceFill,
    required this.borderColor,
    required this.borderWidth,
    required this.cornerRadius,
    required this.navHeight,
  });

  final double blurSigma;
  final Color surfaceFill;
  final Color borderColor;
  final double borderWidth;
  final double cornerRadius;
  final double navHeight;

  static GlassThemeExtension of(BuildContext context) {
    return Theme.of(context).extension<GlassThemeExtension>()!;
  }

  @override
  GlassThemeExtension copyWith({
    double? blurSigma,
    Color? surfaceFill,
    Color? borderColor,
    double? borderWidth,
    double? cornerRadius,
    double? navHeight,
  }) {
    return GlassThemeExtension(
      blurSigma: blurSigma ?? this.blurSigma,
      surfaceFill: surfaceFill ?? this.surfaceFill,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      cornerRadius: cornerRadius ?? this.cornerRadius,
      navHeight: navHeight ?? this.navHeight,
    );
  }

  @override
  GlassThemeExtension lerp(GlassThemeExtension? other, double t) {
    if (other == null) {
      return this;
    }
    return GlassThemeExtension(
      blurSigma: blurSigma + (other.blurSigma - blurSigma) * t,
      surfaceFill: Color.lerp(surfaceFill, other.surfaceFill, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      borderWidth: borderWidth + (other.borderWidth - borderWidth) * t,
      cornerRadius: cornerRadius + (other.cornerRadius - cornerRadius) * t,
      navHeight: navHeight + (other.navHeight - navHeight) * t,
    );
  }
}

@immutable
class AmbientThemeExtension extends ThemeExtension<AmbientThemeExtension> {
  const AmbientThemeExtension({
    required this.primaryGlow,
    required this.secondaryGlow,
    required this.glowBlurSigma,
    required this.primaryOrbSize,
    required this.secondaryOrbSize,
  });

  final Color primaryGlow;
  final Color secondaryGlow;
  final double glowBlurSigma;
  final double primaryOrbSize;
  final double secondaryOrbSize;

  static AmbientThemeExtension of(BuildContext context) {
    return Theme.of(context).extension<AmbientThemeExtension>()!;
  }

  @override
  AmbientThemeExtension copyWith({
    Color? primaryGlow,
    Color? secondaryGlow,
    double? glowBlurSigma,
    double? primaryOrbSize,
    double? secondaryOrbSize,
  }) {
    return AmbientThemeExtension(
      primaryGlow: primaryGlow ?? this.primaryGlow,
      secondaryGlow: secondaryGlow ?? this.secondaryGlow,
      glowBlurSigma: glowBlurSigma ?? this.glowBlurSigma,
      primaryOrbSize: primaryOrbSize ?? this.primaryOrbSize,
      secondaryOrbSize: secondaryOrbSize ?? this.secondaryOrbSize,
    );
  }

  @override
  AmbientThemeExtension lerp(AmbientThemeExtension? other, double t) {
    if (other == null) {
      return this;
    }
    return AmbientThemeExtension(
      primaryGlow: Color.lerp(primaryGlow, other.primaryGlow, t)!,
      secondaryGlow: Color.lerp(secondaryGlow, other.secondaryGlow, t)!,
      glowBlurSigma: glowBlurSigma + (other.glowBlurSigma - glowBlurSigma) * t,
      primaryOrbSize:
          primaryOrbSize + (other.primaryOrbSize - primaryOrbSize) * t,
      secondaryOrbSize:
          secondaryOrbSize + (other.secondaryOrbSize - secondaryOrbSize) * t,
    );
  }
}

const glassThemeExtension = GlassThemeExtension(
  blurSigma: 24,
  surfaceFill: Palette.glassFill,
  borderColor: Palette.glassBorder,
  borderWidth: 1,
  cornerRadius: 24,
  navHeight: 72,
);

const ambientThemeExtension = AmbientThemeExtension(
  primaryGlow: Palette.ember,
  secondaryGlow: Palette.clayGlow,
  glowBlurSigma: 90,
  primaryOrbSize: 280,
  secondaryOrbSize: 220,
);
