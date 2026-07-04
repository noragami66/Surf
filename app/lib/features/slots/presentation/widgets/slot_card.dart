import 'package:flutter/material.dart';
import 'package:glina/core/style/palette.dart';
import 'package:glina/core/widgets/glass_container.dart';
import 'package:glina/core/widgets/glass_icon_badge.dart';
import 'package:glina/features/slots/domain/entities/slot_entity.dart';
import 'package:glina/features/slots/domain/enums/slot_enums.dart';
import 'package:glina/l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class SlotCard extends StatelessWidget {
  const SlotCard({required this.slot, super.key});

  final SlotEntity slot;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final timeFormat = DateFormat('HH:mm');
    final dateFormat = DateFormat('d MMMM', l10n.localeName);
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
              _ProgramBadge(type: slot.program.type),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      slot.program.name,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      slot.master.name,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontSize: 14,
                        color: Palette.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                priceFormat.format(slot.priceAmount),
                style: theme.textTheme.labelLarge?.copyWith(
                  color: Palette.textPrimary,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _MetaChip(
                icon: Icons.calendar_today_outlined,
                label: dateFormat.format(slot.startAt),
              ),
              const SizedBox(width: 8),
              _MetaChip(
                icon: Icons.schedule_outlined,
                label: timeFormat.format(slot.startAt),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _MetaChip(
                icon: Icons.event_seat_outlined,
                label: l10n.slotsSeatsAvailable(slot.freeSeats),
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward_rounded,
                color: Palette.textMuted.withValues(alpha: 0.8),
                size: 18,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProgramBadge extends StatelessWidget {
  const _ProgramBadge({required this.type});

  final ProgramType type;

  @override
  Widget build(BuildContext context) {
    final icon = switch (type) {
      ProgramType.handbuilding => Icons.back_hand_outlined,
      ProgramType.wheel => Icons.album_outlined,
    };

    return GlassIconBadge(
      child: Icon(icon, color: Palette.textSecondary, size: 22),
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Palette.cardFill,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Palette.cardBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Palette.textSecondary),
          const SizedBox(width: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Palette.textSecondary,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
