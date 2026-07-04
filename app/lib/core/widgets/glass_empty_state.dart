import 'package:flutter/material.dart';
import 'package:glina/core/style/app_theme_extensions.dart';
import 'package:glina/core/style/palette.dart';
import 'package:glina/core/widgets/glass_container.dart';
import 'package:glina/core/widgets/glass_icon_badge.dart';
import 'package:glina/core/widgets/glass_primary_button.dart';

/// Empty state inside a solid dark card — icon, text, optional CTA.
class GlassEmptyState extends StatelessWidget {
  const GlassEmptyState({
    required this.icon,
    required this.title,
    required this.subtitle,
    super.key,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final glass = GlassThemeExtension.of(context);
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: glass.screenPaddingH),
      child: GlassContainer(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GlassIconBadge(
              size: glass.iconBoxSize,
              radius: glass.iconBoxRadius,
              child: Icon(
                icon,
                color: Palette.textSecondary,
                size: glass.iconBoxSize * 0.38,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: Palette.textSecondary,
                fontSize: 13,
                height: 1.45,
              ),
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 20),
              GlassPrimaryButton(
                label: actionLabel!,
                onPressed: onAction,
                showTrailingArrow: true,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
