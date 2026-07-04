import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glina/core/widgets/ambient_background.dart';
import 'package:glina/core/widgets/glass_bottom_nav.dart';
import 'package:glina/features/auth/presentation/manager/auth_bloc/auth_bloc.dart';
import 'package:glina/features/auth/presentation/screens/auth_splash_screen.dart';
import 'package:glina/features/auth/presentation/screens/login_screen.dart';
import 'package:glina/features/auth/presentation/screens/name_screen.dart';
import 'package:glina/features/auth/presentation/screens/otp_screen.dart';
import 'package:glina/features/booking/presentation/screens/booking_screen.dart';
import 'package:glina/features/my_bookings/presentation/manager/my_bookings_bloc/my_bookings_bloc.dart';
import 'package:glina/features/my_bookings/presentation/screens/booking_detail_screen.dart';
import 'package:glina/features/my_bookings/presentation/screens/my_bookings_screen.dart';
import 'package:glina/features/slots/presentation/screens/slot_detail_screen.dart';
import 'package:glina/features/slots/presentation/screens/slot_list_screen.dart';
import 'package:glina/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

abstract final class AppRoutes {
  static const splash = '/';
  static const login = '/auth/phone';
  static const otp = '/auth/otp';
  static const name = '/auth/name';
  static const slots = '/slots';
  static const bookings = '/bookings';

  static String slotDetail(String id) => '/slots/$id';
  static String slotBook(String id) => '/slots/$id/book';
  static String bookingDetail(String id) => '/bookings/$id';
}

/// Builds the router with an auth redirect driven by [authBloc] state.
GoRouter createRouter(AuthBloc authBloc) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.splash,
    refreshListenable: _BlocListenable(authBloc.stream),
    redirect: (context, state) =>
        _redirect(authBloc.state, state.matchedLocation),
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (_, __) => const AuthSplashScreen(),
      ),
      GoRoute(path: AppRoutes.login, builder: (_, __) => const LoginScreen()),
      GoRoute(path: AppRoutes.otp, builder: (_, __) => const OtpScreen()),
      GoRoute(path: AppRoutes.name, builder: (_, __) => const NameScreen()),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return _HomeShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.slots,
                builder: (context, state) => const SlotListScreen(),
                routes: [
                  GoRoute(
                    path: ':id',
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) =>
                        SlotDetailScreen(slotId: state.pathParameters['id']!),
                    routes: [
                      GoRoute(
                        path: 'book',
                        parentNavigatorKey: _rootNavigatorKey,
                        builder: (context, state) =>
                            BookingScreen(slotId: state.pathParameters['id']!),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.bookings,
                builder: (context, state) => const MyBookingsScreen(),
                routes: [
                  GoRoute(
                    path: ':id',
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) => BookingDetailScreen(
                      bookingId: state.pathParameters['id']!,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

String? _redirect(AuthState auth, String location) {
  final target = switch (auth.status) {
    AuthStatus.unknown => AppRoutes.splash,
    AuthStatus.unauthenticated => AppRoutes.login,
    AuthStatus.codeSent => AppRoutes.otp,
    AuthStatus.needName => AppRoutes.name,
    AuthStatus.authenticated => null,
  };

  if (target != null) {
    return location == target ? null : target;
  }

  // Authenticated: keep out of auth/splash routes.
  const authRoutes = {
    AppRoutes.splash,
    AppRoutes.login,
    AppRoutes.otp,
    AppRoutes.name,
  };
  if (authRoutes.contains(location)) {
    return AppRoutes.slots;
  }
  return null;
}

/// Bridges a BLoC state stream to a go_router [Listenable].
class _BlocListenable extends ChangeNotifier {
  _BlocListenable(Stream<AuthState> stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription<AuthState> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

class _HomeShell extends StatelessWidget {
  const _HomeShell({required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [const AmbientBackground(), navigationShell],
      ),
      bottomNavigationBar: GlassBottomNav(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          navigationShell.goBranch(index);
          if (index == 1) {
            final clientId = context.read<AuthBloc>().state.client?.id;
            if (clientId != null) {
              context.read<MyBookingsBloc>().add(
                RefreshMyBookingsEvent(clientId),
              );
            }
          }
        },
        destinations: [
          GlassNavDestination(
            icon: Icons.calendar_month_outlined,
            selectedIcon: Icons.calendar_month,
            label: l10n.slotsSectionTitle,
          ),
          GlassNavDestination(
            icon: Icons.event_note_outlined,
            selectedIcon: Icons.event_note,
            label: l10n.myBookingsTab,
          ),
        ],
      ),
    );
  }
}
