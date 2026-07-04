import 'package:flutter/material.dart';
import 'package:glina/core/style/glass_surface.dart';

/// Solid dark badge for icons and avatar initials.
class GlassIconBadge extends StatelessWidget {
  const GlassIconBadge({
    required this.child,
    super.key,
    this.size = 44,
    this.radius = 14,
  });

  final Widget child;
  final double size;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: GlassSurface.badgeDecoration(
        borderRadius: BorderRadius.circular(radius),
      ),
      alignment: Alignment.center,
      child: child,
    );
  }
}
