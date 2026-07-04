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
import 'package:glina/features/booking/presentation/manager/booking_bloc/booking_bloc.dart';
import 'package:glina/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({required this.slotId, super.key});

  final String slotId;

  @override
  Widget build(BuildContext context) {
    final clientId = context.read<AuthBloc>().state.client?.id;
    if (clientId == null) {
      return const SizedBox.shrink();
    }

    return BlocProvider(
      create: (_) =>
          locator<BookingBloc>(param1: slotId, param2: clientId)
            ..add(const LoadBookingSlotEvent()),
      child: const _BookingView(),
    );
  }
}

class _BookingView extends StatelessWidget {
  const _BookingView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final glass = GlassThemeExtension.of(context);

    return BlocConsumer<BookingBloc, BookingState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == BookingFormStatus.success,
      listener: (context, state) {
        context.go('/bookings');
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
                        BookingFormStatus.initial ||
                        BookingFormStatus.loading => Center(
                          child: Text(l10n.loading),
                        ),
                        BookingFormStatus.failure => Center(
                          child: GlassEmptyState(
                            icon: Icons.cloud_off_outlined,
                            title: l10n.slotsErrorTitle,
                            subtitle: l10n.slotsErrorSubtitle,
                          ),
                        ),
                        BookingFormStatus.editing ||
                        BookingFormStatus.submitting ||
                        BookingFormStatus.success => _BookingForm(state: state),
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

class _BookingForm extends StatelessWidget {
  const _BookingForm({required this.state});

  final BookingState state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final glass = GlassThemeExtension.of(context);
    final theme = Theme.of(context);
    final priceFormat = NumberFormat.currency(
      locale: l10n.localeName,
      symbol: '₽',
      decimalDigits: 0,
    );
    final slot = state.slot!;
    final isSubmitting = state.status == BookingFormStatus.submitting;

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
            l10n.bookingTitle,
            style: theme.textTheme.headlineLarge?.copyWith(fontSize: 26),
          ),
          const SizedBox(height: 6),
          Text(
            slot.program.name,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: Palette.textMuted,
            ),
          ),
          const SizedBox(height: 20),
          GlassContainer(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CounterRow(
                  label: l10n.bookingSeatsLabel,
                  value: state.seatsCount,
                  min: 1,
                  max: state.maxSeats,
                  onChanged: (value) => context.read<BookingBloc>().add(
                    BookingSeatsChanged(value),
                  ),
                ),
                const SizedBox(height: 20),
                _CounterRow(
                  label: l10n.bookingRentalLabel,
                  value: state.rentalCount,
                  min: 0,
                  max: state.maxRental,
                  onChanged: (value) => context.read<BookingBloc>().add(
                    BookingRentalChanged(value),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  l10n.bookingRentalHint,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: Palette.textMuted,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          if (state.errorCode != null) ...[
            const SizedBox(height: 12),
            Text(
              _errorMessage(l10n, state.errorCode!),
              style: theme.textTheme.bodyLarge?.copyWith(
                color: Palette.ember,
                fontSize: 13,
              ),
            ),
          ],
          const SizedBox(height: 20),
          GlassContainer(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                Text(
                  l10n.bookingTotalLabel,
                  style: theme.textTheme.headlineSmall?.copyWith(fontSize: 17),
                ),
                const Spacer(),
                Text(
                  priceFormat.format(state.estimatedTotal),
                  style: theme.textTheme.headlineSmall?.copyWith(fontSize: 20),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          GlassPrimaryButton(
            label: l10n.bookingSubmit,
            isLoading: isSubmitting,
            onPressed: isSubmitting
                ? null
                : () => context.read<BookingBloc>().add(
                    const SubmitBookingEvent(),
                  ),
          ),
        ],
      ),
    );
  }

  String _errorMessage(AppLocalizations l10n, String code) {
    return switch (code) {
      'slot_full' => l10n.bookingErrorSlotFull,
      'double_booking' => l10n.bookingErrorDoubleBooking,
      'slot_cancelled' => l10n.bookingErrorSlotCancelled,
      'slot_started' => l10n.bookingErrorSlotStarted,
      'invalid_seats_count' => l10n.bookingErrorInvalidSeats,
      'invalid_rental_count' => l10n.bookingErrorInvalidRental,
      'network_error' => l10n.authErrorNetwork,
      _ => l10n.authErrorGeneric,
    };
  }
}

class _CounterRow extends StatelessWidget {
  const _CounterRow({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  final String label;
  final int value;
  final int min;
  final int max;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: theme.textTheme.bodyLarge?.copyWith(fontSize: 15),
          ),
        ),
        _StepButton(
          icon: Icons.remove_rounded,
          enabled: value > min,
          onPressed: () => onChanged(value - 1),
        ),
        SizedBox(
          width: 36,
          child: Text(
            '$value',
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall?.copyWith(fontSize: 18),
          ),
        ),
        _StepButton(
          icon: Icons.add_rounded,
          enabled: value < max,
          onPressed: () => onChanged(value + 1),
        ),
      ],
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({
    required this.icon,
    required this.enabled,
    required this.onPressed,
  });

  final IconData icon;
  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.35,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: enabled ? onPressed : null,
          borderRadius: BorderRadius.circular(12),
          child: Ink(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Palette.cardFill,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Palette.cardBorder),
            ),
            child: Icon(icon, size: 18, color: Palette.textPrimary),
          ),
        ),
      ),
    );
  }
}
