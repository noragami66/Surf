import 'package:flutter/material.dart';
import 'package:glina/core/style/palette.dart';
import 'package:glina/core/widgets/glass_container.dart';
import 'package:glina/l10n/app_localizations.dart';

class MyBookingsScreen extends StatelessWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.myBookingsTab,
                style: theme.textTheme.headlineLarge?.copyWith(fontSize: 28),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.myBookingsSubtitle,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Palette.textMuted,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              GlassContainer(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 36,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            Palette.clayGlow.withValues(alpha: 0.35),
                            Palette.clayGlow.withValues(alpha: 0.05),
                          ],
                        ),
                        border: Border.all(color: Palette.glassBorder),
                      ),
                      child: const Icon(
                        Icons.event_note_outlined,
                        color: Palette.textSecondary,
                        size: 32,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      l10n.myBookingsEmptyTitle,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.myBookingsEmptySubtitle,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyLarge?.copyWith(fontSize: 14),
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
