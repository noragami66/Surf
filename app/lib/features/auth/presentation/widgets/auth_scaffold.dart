import 'package:flutter/material.dart';
import 'package:glina/core/style/app_theme_extensions.dart';
import 'package:glina/core/style/palette.dart';
import 'package:glina/core/widgets/ambient_background.dart';

/// Shared shell for auth steps — header at top, form content below.
class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    required this.title,
    required this.subtitle,
    required this.children,
    super.key,
    this.onBack,
  });

  final String title;
  final String subtitle;
  final List<Widget> children;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    final glass = GlassThemeExtension.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Palette.voidBlack,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const AmbientBackground(),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                glass.screenPaddingH,
                glass.screenPaddingTop,
                glass.screenPaddingH,
                16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (onBack != null) ...[
                    _BackButton(onTap: onBack!),
                    const SizedBox(height: 12),
                  ],
                  Text(title, style: theme.textTheme.headlineLarge),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: Palette.textMuted,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 28),
                  ...children,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Palette.glassBorder),
          ),
          child: const Icon(
            Icons.arrow_back_rounded,
            color: Palette.textPrimary,
            size: 20,
          ),
        ),
      ),
    );
  }
}
