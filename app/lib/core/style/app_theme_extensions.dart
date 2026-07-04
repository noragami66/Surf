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
    required this.navIconSize,
    required this.navFontSize,
    required this.iconBoxSize,
    required this.iconBoxRadius,
    required this.ctaHeight,
    required this.ctaRadius,
    required this.ctaGlowBlur,
    required this.activeDotSize,
    required this.avatarSize,
    required this.avatarRadius,
    required this.screenPaddingH,
    required this.screenPaddingTop,
    required this.sectionGap,
  });

  final double blurSigma;
  final Color surfaceFill;
  final Color borderColor;
  final double borderWidth;
  final double cornerRadius;
  final double navHeight;
  final double navIconSize;
  final double navFontSize;
  final double iconBoxSize;
  final double iconBoxRadius;
  final double ctaHeight;
  final double ctaRadius;
  final double ctaGlowBlur;
  final double activeDotSize;
  final double avatarSize;
  final double avatarRadius;
  final double screenPaddingH;
  final double screenPaddingTop;
  final double sectionGap;

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
    double? navIconSize,
    double? navFontSize,
    double? iconBoxSize,
    double? iconBoxRadius,
    double? ctaHeight,
    double? ctaRadius,
    double? ctaGlowBlur,
    double? activeDotSize,
    double? avatarSize,
    double? avatarRadius,
    double? screenPaddingH,
    double? screenPaddingTop,
    double? sectionGap,
  }) {
    return GlassThemeExtension(
      blurSigma: blurSigma ?? this.blurSigma,
      surfaceFill: surfaceFill ?? this.surfaceFill,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      cornerRadius: cornerRadius ?? this.cornerRadius,
      navHeight: navHeight ?? this.navHeight,
      navIconSize: navIconSize ?? this.navIconSize,
      navFontSize: navFontSize ?? this.navFontSize,
      iconBoxSize: iconBoxSize ?? this.iconBoxSize,
      iconBoxRadius: iconBoxRadius ?? this.iconBoxRadius,
      ctaHeight: ctaHeight ?? this.ctaHeight,
      ctaRadius: ctaRadius ?? this.ctaRadius,
      ctaGlowBlur: ctaGlowBlur ?? this.ctaGlowBlur,
      activeDotSize: activeDotSize ?? this.activeDotSize,
      avatarSize: avatarSize ?? this.avatarSize,
      avatarRadius: avatarRadius ?? this.avatarRadius,
      screenPaddingH: screenPaddingH ?? this.screenPaddingH,
      screenPaddingTop: screenPaddingTop ?? this.screenPaddingTop,
      sectionGap: sectionGap ?? this.sectionGap,
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
      navIconSize: navIconSize + (other.navIconSize - navIconSize) * t,
      navFontSize: navFontSize + (other.navFontSize - navFontSize) * t,
      iconBoxSize: iconBoxSize + (other.iconBoxSize - iconBoxSize) * t,
      iconBoxRadius: iconBoxRadius + (other.iconBoxRadius - iconBoxRadius) * t,
      ctaHeight: ctaHeight + (other.ctaHeight - ctaHeight) * t,
      ctaRadius: ctaRadius + (other.ctaRadius - ctaRadius) * t,
      ctaGlowBlur: ctaGlowBlur + (other.ctaGlowBlur - ctaGlowBlur) * t,
      activeDotSize: activeDotSize + (other.activeDotSize - activeDotSize) * t,
      avatarSize: avatarSize + (other.avatarSize - avatarSize) * t,
      avatarRadius: avatarRadius + (other.avatarRadius - avatarRadius) * t,
      screenPaddingH:
          screenPaddingH + (other.screenPaddingH - screenPaddingH) * t,
      screenPaddingTop:
          screenPaddingTop + (other.screenPaddingTop - screenPaddingTop) * t,
      sectionGap: sectionGap + (other.sectionGap - sectionGap) * t,
    );
  }
}

@immutable
class AmbientThemeExtension extends ThemeExtension<AmbientThemeExtension> {
  const AmbientThemeExtension({
    required this.primaryGlow,
    required this.secondaryGlow,
    required this.tertiaryGlow,
    required this.glowBlurSigma,
    required this.primaryOrbSize,
    required this.secondaryOrbSize,
    required this.primaryOpacity,
    required this.secondaryOpacity,
    required this.tertiaryOpacity,
  });

  final Color primaryGlow;
  final Color secondaryGlow;
  final Color tertiaryGlow;
  final double glowBlurSigma;
  final double primaryOrbSize;
  final double secondaryOrbSize;
  final double primaryOpacity;
  final double secondaryOpacity;
  final double tertiaryOpacity;

  static AmbientThemeExtension of(BuildContext context) {
    return Theme.of(context).extension<AmbientThemeExtension>()!;
  }

  @override
  AmbientThemeExtension copyWith({
    Color? primaryGlow,
    Color? secondaryGlow,
    Color? tertiaryGlow,
    double? glowBlurSigma,
    double? primaryOrbSize,
    double? secondaryOrbSize,
    double? primaryOpacity,
    double? secondaryOpacity,
    double? tertiaryOpacity,
  }) {
    return AmbientThemeExtension(
      primaryGlow: primaryGlow ?? this.primaryGlow,
      secondaryGlow: secondaryGlow ?? this.secondaryGlow,
      tertiaryGlow: tertiaryGlow ?? this.tertiaryGlow,
      glowBlurSigma: glowBlurSigma ?? this.glowBlurSigma,
      primaryOrbSize: primaryOrbSize ?? this.primaryOrbSize,
      secondaryOrbSize: secondaryOrbSize ?? this.secondaryOrbSize,
      primaryOpacity: primaryOpacity ?? this.primaryOpacity,
      secondaryOpacity: secondaryOpacity ?? this.secondaryOpacity,
      tertiaryOpacity: tertiaryOpacity ?? this.tertiaryOpacity,
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
      tertiaryGlow: Color.lerp(tertiaryGlow, other.tertiaryGlow, t)!,
      glowBlurSigma: glowBlurSigma + (other.glowBlurSigma - glowBlurSigma) * t,
      primaryOrbSize:
          primaryOrbSize + (other.primaryOrbSize - primaryOrbSize) * t,
      secondaryOrbSize:
          secondaryOrbSize + (other.secondaryOrbSize - secondaryOrbSize) * t,
      primaryOpacity:
          primaryOpacity + (other.primaryOpacity - primaryOpacity) * t,
      secondaryOpacity:
          secondaryOpacity + (other.secondaryOpacity - secondaryOpacity) * t,
      tertiaryOpacity:
          tertiaryOpacity + (other.tertiaryOpacity - tertiaryOpacity) * t,
    );
  }
}

const glassThemeExtension = GlassThemeExtension(
  blurSigma: 24,
  surfaceFill: Palette.glassFill,
  borderColor: Palette.glassBorderLight,
  borderWidth: 1,
  cornerRadius: 24,
  navHeight: 56,
  navIconSize: 20,
  navFontSize: 10,
  iconBoxSize: 72,
  iconBoxRadius: 20,
  ctaHeight: 52,
  ctaRadius: 26,
  ctaGlowBlur: 32,
  activeDotSize: 4,
  avatarSize: 44,
  avatarRadius: 14,
  screenPaddingH: 16,
  screenPaddingTop: 12,
  sectionGap: 20,
);

const ambientThemeExtension = AmbientThemeExtension(
  primaryGlow: Palette.emeraldGlow,
  secondaryGlow: Palette.cyanGlow,
  tertiaryGlow: Palette.blueSoft,
  glowBlurSigma: 105,
  primaryOrbSize: 400,
  secondaryOrbSize: 300,
  primaryOpacity: 0.42,
  secondaryOpacity: 0.22,
  tertiaryOpacity: 0.16,
);
