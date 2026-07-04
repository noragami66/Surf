import 'package:flutter/material.dart';
import 'package:glina/core/style/app_theme_extensions.dart';
import 'package:glina/core/style/palette.dart';

/// White pill CTA with a soft outer glow — primary action across the app.
class GlassPrimaryButton extends StatelessWidget {
  const GlassPrimaryButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.isLoading = false,
    this.showTrailingArrow = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool showTrailingArrow;

  @override
  Widget build(BuildContext context) {
    final glass = GlassThemeExtension.of(context);
    final theme = Theme.of(context);
    final enabled = onPressed != null && !isLoading;

    return Opacity(
      opacity: enabled ? 1 : 0.45,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: enabled ? onPressed : null,
          borderRadius: BorderRadius.circular(glass.ctaRadius),
          child: Ink(
            decoration: BoxDecoration(
              color: Palette.ctaWhite,
              borderRadius: BorderRadius.circular(glass.ctaRadius),
              boxShadow: [
                BoxShadow(
                  color: Palette.ctaWhite.withValues(alpha: 0.28),
                  blurRadius: glass.ctaGlowBlur,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: SizedBox(
              height: glass.ctaHeight,
              child: Center(
                child: isLoading
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Palette.ctaForeground,
                        ),
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            label,
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: Palette.ctaForeground,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (showTrailingArrow) ...[
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.arrow_forward_rounded,
                              color: Palette.ctaForeground,
                              size: 18,
                            ),
                          ],
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
