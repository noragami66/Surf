import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glina/features/slots/presentation/manager/slots_bloc/slots_bloc.dart';
import 'package:glina/l10n/app_localizations.dart';

class SlotListScreen extends StatelessWidget {
  const SlotListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.slotsTab)),
      body: BlocBuilder<SlotsBloc, SlotsState>(
        builder: (context, state) {
          return switch (state.status) {
            SlotsStatus.initial || SlotsStatus.loading => Center(
              child: Text(l10n.loading),
            ),
            SlotsStatus.empty => Center(
              child: Text(l10n.slotsEmptyTitle),
            ),
            SlotsStatus.loaded => ListView.builder(
              itemCount: state.slots.length,
              itemBuilder: (context, index) {
                final slot = state.slots[index];
                return ListTile(
                  title: Text(slot.program.name),
                  subtitle: Text(slot.master.name),
                );
              },
            ),
            SlotsStatus.failure => Center(
              child: Text(state.errorMessage ?? 'Error'),
            ),
          };
        },
      ),
    );
  }
}
