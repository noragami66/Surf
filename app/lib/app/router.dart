import 'package:flutter/material.dart';
import 'package:glina/core/widgets/ambient_background.dart';
import 'package:glina/core/widgets/glass_bottom_nav.dart';
import 'package:glina/features/my_bookings/presentation/screens/my_bookings_screen.dart';
import 'package:glina/features/slots/presentation/screens/slot_list_screen.dart';
import 'package:glina/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/slots',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        final l10n = AppLocalizations.of(context)!;

        return Scaffold(
          extendBody: true,
          backgroundColor: Colors.transparent,
          body: Stack(
            fit: StackFit.expand,
            children: [
              const AmbientBackground(),
              navigationShell,
            ],
          ),
          bottomNavigationBar: GlassBottomNav(
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: navigationShell.goBranch,
            destinations: [
              GlassNavDestination(
                icon: Icons.calendar_month_outlined,
                selectedIcon: Icons.calendar_month,
                label: l10n.slotsTab,
              ),
              GlassNavDestination(
                icon: Icons.event_note_outlined,
                selectedIcon: Icons.event_note,
                label: l10n.myBookingsTab,
              ),
            ],
          ),
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/slots',
              builder: (context, state) => const SlotListScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/bookings',
              builder: (context, state) => const MyBookingsScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
