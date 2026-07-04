import 'package:flutter/material.dart';
import 'package:glina/core/style/palette.dart';
import 'package:glina/core/widgets/glass_container.dart';
import 'package:glina/features/booking/domain/enums/booking_enums.dart';
import 'package:glina/features/my_bookings/domain/entities/booking_list_item_entity.dart';
import 'package:glina/l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class BookingCard extends StatelessWidget {
  const BookingCard({required this.item, super.key});

  final BookingListItemEntity item;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final booking = item.booking;
    final slot = item.slot;
    final dateFormat = DateFormat('d MMMM, HH:mm', l10n.localeName);
    final priceFormat = NumberFormat.currency(
      locale: l10n.localeName,
      symbol: '₽',
      decimalDigits: 0,
    );

    return GlassContainer(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  slot.program.name,
                  style: theme.textTheme.headlineSmall?.copyWith(fontSize: 17),
                ),
              ),
              _StatusChip(status: booking.status, label: _statusLabel(l10n)),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            slot.master.name,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontSize: 14,
              color: Palette.textMuted,
            ),
          ),
          const SizedBox(height: 14),
          _MetaRow(
            icon: Icons.calendar_today_outlined,
            label: dateFormat.format(slot.startAt),
          ),
          const SizedBox(height: 8),
          _MetaRow(
            icon: Icons.event_seat_outlined,
            label: l10n.myBookingsSeatsCount(booking.seatsCount),
          ),
          if (booking.rentalCount > 0) ...[
            const SizedBox(height: 8),
            _MetaRow(
              icon: Icons.inventory_2_outlined,
              label: l10n.myBookingsRentalCount(booking.rentalCount),
            ),
          ],
          const SizedBox(height: 14),
          Text(
            priceFormat.format(booking.priceTotal),
            style: theme.textTheme.labelLarge?.copyWith(
              color: Palette.textPrimary,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  String _statusLabel(AppLocalizations l10n) {
    return switch (item.booking.status) {
      BookingStatus.active => l10n.myBookingsStatusActive,
      BookingStatus.cancelled => l10n.myBookingsStatusCancelled,
      BookingStatus.lateCancel => l10n.myBookingsStatusLateCancel,
      BookingStatus.workshopCancelled => l10n.myBookingsStatusWorkshopCancelled,
    };
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status, required this.label});

  final BookingStatus status;
  final String label;

  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      BookingStatus.active => Palette.emeraldGlow,
      BookingStatus.cancelled || BookingStatus.lateCancel => Palette.textMuted,
      BookingStatus.workshopCancelled => Palette.ember,
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Text(
        label,
        style: Theme.of(
          context,
        ).textTheme.labelLarge?.copyWith(color: color, fontSize: 11),
      ),
    );
  }
}

class _MetaRow extends StatelessWidget {
  const _MetaRow({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Palette.textSecondary),
        const SizedBox(width: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Palette.textSecondary,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
