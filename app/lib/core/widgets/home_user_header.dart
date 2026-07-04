import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glina/core/style/app_theme_extensions.dart';
import 'package:glina/core/style/palette.dart';
import 'package:glina/core/widgets/glass_icon_badge.dart';
import 'package:glina/features/auth/presentation/manager/auth_bloc/auth_bloc.dart';
import 'package:glina/l10n/app_localizations.dart';

/// Greeting row with glass avatar and the authenticated user's name.
class HomeUserHeader extends StatelessWidget {
  const HomeUserHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final glass = GlassThemeExtension.of(context);
    final theme = Theme.of(context);

    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) =>
          previous.client?.name != current.client?.name,
      builder: (context, state) {
        final name = state.client?.name.trim();
        final displayName = (name != null && name.isNotEmpty) ? name : '—';
        final initial = displayName[0].toUpperCase();

        return Row(
          children: [
            GlassIconBadge(
              size: glass.avatarSize,
              radius: glass.avatarRadius,
              child: Text(
                initial,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: Palette.textSecondary,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.homeGreeting(displayName),
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    l10n.homeGreetingSubtitle,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: Palette.textMuted,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

/// Page title + subtitle below the user greeting.
class ScreenPageHeader extends StatelessWidget {
  const ScreenPageHeader({
    required this.title,
    required this.subtitle,
    super.key,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.headlineLarge?.copyWith(fontSize: 26),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: Palette.textMuted,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
