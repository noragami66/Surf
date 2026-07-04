import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glina/core/style/palette.dart';
import 'package:glina/features/slots/domain/enums/slot_enums.dart';
import 'package:glina/features/slots/presentation/manager/slots_bloc/slots_bloc.dart';
import 'package:glina/l10n/app_localizations.dart';

class SlotFiltersBar extends StatelessWidget {
  const SlotFiltersBar({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<SlotsBloc, SlotsState>(
      buildWhen: (previous, current) =>
          previous.filter != current.filter ||
          previous.masters != current.masters,
      builder: (context, state) {
        final filter = state.filter;
        final bloc = context.read<SlotsBloc>();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.slotsPeriodLabel,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Palette.textMuted,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _FilterChip(
                    label: l10n.slotsFilterHandbuilding,
                    selected: filter.programTypes.contains(
                      ProgramType.handbuilding,
                    ),
                    onSelected: () => bloc.add(
                      const ToggleProgramTypeFilterEvent(
                        ProgramType.handbuilding,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: l10n.slotsFilterWheel,
                    selected: filter.programTypes.contains(ProgramType.wheel),
                    onSelected: () => bloc.add(
                      const ToggleProgramTypeFilterEvent(ProgramType.wheel),
                    ),
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: l10n.slotsFilterOnlyAvailable,
                    selected: filter.onlyAvailable,
                    onSelected: () =>
                        bloc.add(const ToggleOnlyAvailableFilterEvent()),
                  ),
                  for (final master in state.masters) ...[
                    const SizedBox(width: 8),
                    _FilterChip(
                      label: master.name,
                      selected: filter.masterIds.contains(master.id),
                      onSelected: () => bloc.add(
                        ToggleMasterFilterEvent(master.id),
                      ),
                    ),
                  ],
                  if (filter.hasActiveFilters) ...[
                    const SizedBox(width: 8),
                    _FilterChip(
                      label: l10n.slotsFilterClear,
                      selected: false,
                      isClear: true,
                      onSelected: () =>
                          bloc.add(const ClearSlotsFiltersEvent()),
                    ),
                  ],
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onSelected,
    this.isClear = false,
  });

  final String label;
  final bool selected;
  final VoidCallback onSelected;
  final bool isClear;

  @override
  Widget build(BuildContext context) {
    final background = selected
        ? Palette.ember.withValues(alpha: 0.22)
        : Palette.cardFill;
    final borderColor = selected ? Palette.ember : Palette.cardBorder;
    final textColor = selected ? Palette.textPrimary : Palette.textSecondary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onSelected,
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          decoration: BoxDecoration(
            color: isClear ? Colors.transparent : background,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isClear ? Palette.textMuted : borderColor,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: isClear ? Palette.textMuted : textColor,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
