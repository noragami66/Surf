import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glina/core/style/app_theme_extensions.dart';
import 'package:glina/core/style/palette.dart';
import 'package:glina/core/widgets/ambient_background.dart';
import 'package:glina/core/widgets/glass_container.dart';
import 'package:glina/core/widgets/glass_empty_state.dart';
import 'package:glina/core/widgets/glass_primary_button.dart';
import 'package:glina/dependency_injection/locator/locator.dart';
import 'package:glina/features/auth/presentation/manager/auth_bloc/auth_bloc.dart';
import 'package:glina/features/my_bookings/domain/entities/booking_list_item_entity.dart';
import 'package:glina/features/my_bookings/presentation/manager/booking_detail_bloc/booking_detail_bloc.dart';
import 'package:glina/features/my_bookings/presentation/manager/my_bookings_bloc/my_bookings_bloc.dart';
import 'package:glina/features/my_bookings/presentation/widgets/booking_card.dart';
import 'package:glina/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class BookingDetailScreen extends StatelessWidget {
  const BookingDetailScreen({required this.bookingId, super.key});

  final String bookingId;

  @override
  Widget build(BuildContext context) {
    final clientId = context.read<AuthBloc>().state.client?.id;
    if (clientId == null) {
      return const SizedBox.shrink();
    }

    return BlocProvider(
      create: (_) =>
          locator<BookingDetailBloc>(param1: bookingId, param2: clientId)
            ..add(const LoadBookingDetailEvent()),
      child: const _BookingDetailView(),
    );
  }
}

class _BookingDetailView extends StatelessWidget {
  const _BookingDetailView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final glass = GlassThemeExtension.of(context);

    return BlocConsumer<BookingDetailBloc, BookingDetailState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == BookingDetailStatus.cancelled,
      listener: (context, state) {
        final clientId = context.read<AuthBloc>().state.client?.id;
        if (clientId != null) {
          context.read<MyBookingsBloc>().add(RefreshMyBookingsEvent(clientId));
        }
        context.pop();
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            fit: StackFit.expand,
            children: [
              const AmbientBackground(),
              SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        glass.screenPaddingH,
                        8,
                        glass.screenPaddingH,
                        0,
                      ),
                      child: IconButton(
                        onPressed: () => context.pop(),
                        icon: const Icon(Icons.arrow_back_rounded),
                        color: Palette.textPrimary,
                      ),
                    ),
                    Expanded(
                      child: switch (state.status) {
                        BookingDetailStatus.initial ||
                        BookingDetailStatus.loading ||
                        BookingDetailStatus.cancelling => Center(
                          child: Text(l10n.loading),
                        ),
                        BookingDetailStatus.failure => Center(
                          child: GlassEmptyState(
                            icon: Icons.event_busy_outlined,
                            title: l10n.bookingDetailNotFoundTitle,
                            subtitle: l10n.bookingDetailNotFoundSubtitle,
                          ),
                        ),
                        BookingDetailStatus.loaded ||
                        BookingDetailStatus.cancelled => _LoadedDetail(
                          item: state.item!,
                          errorCode: state.errorCode,
                          isCancelling:
                              state.status == BookingDetailStatus.cancelling,
                        ),
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _LoadedDetail extends StatelessWidget {
  const _LoadedDetail({
    required this.item,
    required this.errorCode,
    required this.isCancelling,
  });

  final BookingListItemEntity item;
  final String? errorCode;
  final bool isCancelling;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final glass = GlassThemeExtension.of(context);
    final theme = Theme.of(context);
    final booking = item.booking;
    final canCancel = booking.isCancellable;

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        glass.screenPaddingH,
        8,
        glass.screenPaddingH,
        24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.bookingDetailTitle,
            style: theme.textTheme.headlineLarge?.copyWith(fontSize: 26),
          ),
          const SizedBox(height: 16),
          BookingCard(item: item, onTap: () {}),
          if (booking.workshopCancelReason != null) ...[
            const SizedBox(height: 12),
            GlassContainer(
              padding: const EdgeInsets.all(16),
              child: Text(
                l10n.bookingDetailWorkshopReason(booking.workshopCancelReason!),
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Palette.ember,
                  fontSize: 13,
                ),
              ),
            ),
          ],
          if (booking.cancelledAt != null) ...[
            const SizedBox(height: 12),
            Text(
              l10n.bookingDetailCancelledAt(
                DateFormat(
                  'd MMMM yyyy, HH:mm',
                  l10n.localeName,
                ).format(booking.cancelledAt!),
              ),
              style: theme.textTheme.bodyLarge?.copyWith(
                color: Palette.textMuted,
                fontSize: 13,
              ),
            ),
          ],
          if (errorCode != null) ...[
            const SizedBox(height: 12),
            Text(
              _errorMessage(l10n, errorCode!),
              style: theme.textTheme.bodyLarge?.copyWith(
                color: Palette.ember,
                fontSize: 13,
              ),
            ),
          ],
          if (canCancel) ...[
            const SizedBox(height: 24),
            GlassPrimaryButton(
              label: l10n.bookingDetailCancelCta,
              isLoading: isCancelling,
              onPressed: isCancelling
                  ? null
                  : () => _confirmCancel(context, l10n),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _confirmCancel(
    BuildContext context,
    AppLocalizations l10n,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Palette.surfaceElevated,
        title: Text(l10n.bookingDetailCancelDialogTitle),
        content: Text(l10n.bookingDetailCancelDialogBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.bookingDetailCancelDialogDismiss),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.bookingDetailCancelDialogConfirm),
          ),
        ],
      ),
    );

    if ((confirmed ?? false) && context.mounted) {
      context.read<BookingDetailBloc>().add(const CancelBookingEvent());
    }
  }

  String _errorMessage(AppLocalizations l10n, String code) {
    return switch (code) {
      'booking_already_cancelled' => l10n.bookingDetailErrorAlreadyCancelled,
      'booking_cancel_slot_started' => l10n.bookingDetailErrorSlotStarted,
      'network_error' => l10n.authErrorNetwork,
      _ => l10n.authErrorGeneric,
    };
  }
}
