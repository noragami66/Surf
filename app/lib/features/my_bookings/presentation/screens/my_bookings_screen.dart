import 'package:flutter/material.dart';
import 'package:glina/core/style/app_theme_extensions.dart';
import 'package:glina/core/widgets/glass_empty_state.dart';
import 'package:glina/core/widgets/home_user_header.dart';
import 'package:glina/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class MyBookingsScreen extends StatelessWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final glass = GlassThemeExtension.of(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                glass.screenPaddingH,
                glass.screenPaddingTop,
                glass.screenPaddingH,
                0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HomeUserHeader(),
                  SizedBox(height: glass.sectionGap),
                  ScreenPageHeader(
                    title: l10n.myBookingsTab,
                    subtitle: l10n.myBookingsSubtitle,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: GlassEmptyState(
                  icon: Icons.event_busy_outlined,
                  title: l10n.myBookingsEmptyTitle,
                  subtitle: l10n.myBookingsEmptySubtitle,
                  actionLabel: l10n.myBookingsGoToSchedule,
                  onAction: () => context.go('/slots'),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
