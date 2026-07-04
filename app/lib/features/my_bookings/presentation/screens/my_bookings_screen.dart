import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glina/core/style/app_theme_extensions.dart';
import 'package:glina/core/widgets/glass_empty_state.dart';
import 'package:glina/core/widgets/home_user_header.dart';
import 'package:glina/features/auth/presentation/manager/auth_bloc/auth_bloc.dart';
import 'package:glina/features/my_bookings/presentation/manager/my_bookings_bloc/my_bookings_bloc.dart';
import 'package:glina/features/my_bookings/presentation/widgets/booking_card.dart';
import 'package:glina/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({super.key});

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadBookings());
  }

  void _loadBookings() {
    final clientId = context.read<AuthBloc>().state.client?.id;
    if (clientId != null) {
      context.read<MyBookingsBloc>().add(LoadMyBookingsEvent(clientId));
    }
  }

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
              child: BlocBuilder<MyBookingsBloc, MyBookingsState>(
                builder: (context, state) {
                  return switch (state.status) {
                    MyBookingsStatus.initial || MyBookingsStatus.loading =>
                      Center(child: Text(l10n.loading)),
                    MyBookingsStatus.empty => Center(
                      child: GlassEmptyState(
                        icon: Icons.event_busy_outlined,
                        title: l10n.myBookingsEmptyTitle,
                        subtitle: l10n.myBookingsEmptySubtitle,
                        actionLabel: l10n.myBookingsGoToSchedule,
                        onAction: () => context.go('/slots'),
                      ),
                    ),
                    MyBookingsStatus.loaded => ListView.builder(
                      padding: EdgeInsets.fromLTRB(
                        glass.screenPaddingH,
                        16,
                        glass.screenPaddingH,
                        16,
                      ),
                      itemCount: state.items.length,
                      itemBuilder: (context, index) {
                        return BookingCard(item: state.items[index]);
                      },
                    ),
                    MyBookingsStatus.failure => Center(
                      child: GlassEmptyState(
                        icon: Icons.cloud_off_outlined,
                        title: l10n.slotsErrorTitle,
                        subtitle: state.errorMessage ?? l10n.slotsErrorSubtitle,
                      ),
                    ),
                  };
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
