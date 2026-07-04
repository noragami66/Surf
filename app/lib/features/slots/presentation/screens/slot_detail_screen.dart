import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glina/core/style/app_theme_extensions.dart';
import 'package:glina/core/style/palette.dart';
import 'package:glina/core/widgets/ambient_background.dart';
import 'package:glina/core/widgets/glass_container.dart';
import 'package:glina/core/widgets/glass_empty_state.dart';
import 'package:glina/core/widgets/glass_icon_badge.dart';
import 'package:glina/core/widgets/glass_primary_button.dart';
import 'package:glina/dependency_injection/locator/locator.dart';
import 'package:glina/features/slots/domain/entities/slot_entity.dart';
import 'package:glina/features/slots/presentation/manager/slot_detail_bloc/slot_detail_bloc.dart';
import 'package:glina/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class SlotDetailScreen extends StatelessWidget {
  const SlotDetailScreen({required this.slotId, super.key});

  final String slotId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          locator<SlotDetailBloc>(param1: slotId)
            ..add(const LoadSlotDetailEvent()),
      child: const _SlotDetailView(),
    );
  }
}

class _SlotDetailView extends StatelessWidget {
  const _SlotDetailView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final glass = GlassThemeExtension.of(context);

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
                  child: BlocBuilder<SlotDetailBloc, SlotDetailState>(
                    builder: (context, state) {
                      return switch (state.status) {
                        SlotDetailStatus.initial || SlotDetailStatus.loading =>
                          Center(child: Text(l10n.loading)),
                        SlotDetailStatus.notFound => Center(
                          child: GlassEmptyState(
                            icon: Icons.event_busy_outlined,
                            title: l10n.slotDetailNotFoundTitle,
                            subtitle: l10n.slotDetailNotFoundSubtitle,
                          ),
                        ),
                        SlotDetailStatus.failure => Center(
                          child: GlassEmptyState(
                            icon: Icons.cloud_off_outlined,
                            title: l10n.slotsErrorTitle,
                            subtitle: l10n.slotsErrorSubtitle,
                          ),
                        ),
                        SlotDetailStatus.loaded => _LoadedContent(
                          slot: state.slot!,
                          canBook: state.canBook,
                        ),
                      };
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadedContent extends StatelessWidget {
  const _LoadedContent({required this.slot, required this.canBook});

  final SlotEntity slot;
  final bool canBook;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final glass = GlassThemeExtension.of(context);
    final theme = Theme.of(context);
    final dateFormat = DateFormat('d MMMM yyyy, HH:mm', l10n.localeName);
    final priceFormat = NumberFormat.currency(
      locale: l10n.localeName,
      symbol: '₽',
      decimalDigits: 0,
    );

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
            slot.program.name,
            style: theme.textTheme.headlineLarge?.copyWith(fontSize: 26),
          ),
          const SizedBox(height: 8),
          Text(
            slot.master.name,
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
                _DetailRow(
                  icon: Icons.calendar_today_outlined,
                  label: l10n.slotDetailDateTime,
                  value: dateFormat.format(slot.startAt),
                ),
                const SizedBox(height: 14),
                _DetailRow(
                  icon: Icons.schedule_outlined,
                  label: l10n.slotDetailDuration,
                  value: l10n.slotDetailDurationMin(slot.program.durationMin),
                ),
                const SizedBox(height: 14),
                _DetailRow(
                  icon: Icons.place_outlined,
                  label: l10n.slotDetailAddress,
                  value: slot.workshopAddress,
                ),
                const SizedBox(height: 14),
                _DetailRow(
                  icon: Icons.event_seat_outlined,
                  label: l10n.slotDetailSeats,
                  value: l10n.slotsSeatsAvailable(slot.freeSeats),
                ),
                const SizedBox(height: 14),
                _DetailRow(
                  icon: Icons.inventory_2_outlined,
                  label: l10n.slotDetailRental,
                  value: l10n.slotDetailRentalAvailable(slot.freeRentalKits),
                ),
                const SizedBox(height: 14),
                _DetailRow(
                  icon: Icons.payments_outlined,
                  label: l10n.slotDetailPrice,
                  value: priceFormat.format(slot.priceAmount),
                ),
                if (slot.rentalPriceAmount > 0) ...[
                  const SizedBox(height: 14),
                  _DetailRow(
                    icon: Icons.handyman_outlined,
                    label: l10n.slotDetailRentalPrice,
                    value: priceFormat.format(slot.rentalPriceAmount),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 24),
          GlassPrimaryButton(
            label: l10n.slotDetailBookCta,
            onPressed: canBook ? () => context.push('book') : null,
            showTrailingArrow: true,
          ),
          if (!canBook) ...[
            const SizedBox(height: 12),
            Text(
              l10n.slotDetailBookUnavailable,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: Palette.textMuted,
                fontSize: 13,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GlassIconBadge(
          size: 36,
          radius: 12,
          child: Icon(icon, size: 18, color: Palette.textSecondary),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: Palette.textMuted,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: theme.textTheme.bodyLarge?.copyWith(fontSize: 15),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
