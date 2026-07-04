import 'package:flutter/material.dart';
import 'package:glina/core/style/app_theme_extensions.dart';
import 'package:glina/core/style/glass_surface.dart';

/// Solid dark panel for slot cards and empty states.
class GlassContainer extends StatelessWidget {
  const GlassContainer({
    required this.child,
    super.key,
    this.padding,
    this.margin,
    this.borderRadius,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final glass = GlassThemeExtension.of(context);
    final radius = borderRadius ?? BorderRadius.circular(glass.cornerRadius);

    final content = DecoratedBox(
      decoration: GlassSurface.cardDecoration(borderRadius: radius),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(20),
        child: child,
      ),
    );

    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: onTap == null
          ? content
          : Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                borderRadius: radius,
                child: content,
              ),
            ),
    );
  }
}
