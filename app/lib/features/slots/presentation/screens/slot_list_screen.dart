import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glina/core/style/app_theme_extensions.dart';
import 'package:glina/core/style/palette.dart';
import 'package:glina/core/widgets/glass_empty_state.dart';
import 'package:glina/core/widgets/home_user_header.dart';
import 'package:glina/features/slots/presentation/manager/slots_bloc/slots_bloc.dart';
import 'package:glina/features/slots/presentation/widgets/slot_card.dart';
import 'package:glina/l10n/app_localizations.dart';

class SlotListScreen extends StatelessWidget {
  const SlotListScreen({super.key});

  Future<void> _onRefresh(BuildContext context) async {
    final bloc = context.read<SlotsBloc>()..add(const RefreshSlotsEvent());
    await bloc.stream.firstWhere(
      (state) => state.status != SlotsStatus.loading,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final glass = GlassThemeExtension.of(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<SlotsBloc, SlotsState>(
          builder: (context, state) {
            return RefreshIndicator(
              color: Palette.textPrimary,
              backgroundColor: Palette.surfaceElevated,
              onRefresh: () => _onRefresh(context),
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
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
                            title: l10n.slotsSectionTitle,
                            subtitle: l10n.appTagline,
                          ),
                        ],
                      ),
                    ),
                  ),
                  switch (state.status) {
                    SlotsStatus.initial ||
                    SlotsStatus.loading => SliverFillRemaining(
                      hasScrollBody: false,
                      child: _LoadingState(message: l10n.loading),
                    ),
                    SlotsStatus.empty => SliverFillRemaining(
                      hasScrollBody: false,
                      child: GlassEmptyState(
                        icon: Icons.calendar_month_outlined,
                        title: l10n.slotsEmptyTitle,
                        subtitle: l10n.slotsEmptySubtitle,
                      ),
                    ),
                    SlotsStatus.loaded => SliverPadding(
                      padding: EdgeInsets.fromLTRB(
                        glass.screenPaddingH,
                        16,
                        glass.screenPaddingH,
                        16,
                      ),
                      sliver: SliverList.separated(
                        itemCount: state.slots.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 0),
                        itemBuilder: (context, index) {
                          return SlotCard(slot: state.slots[index]);
                        },
                      ),
                    ),
                    SlotsStatus.failure => SliverFillRemaining(
                      hasScrollBody: false,
                      child: GlassEmptyState(
                        icon: Icons.cloud_off_outlined,
                        title: l10n.slotsErrorTitle,
                        subtitle: state.errorMessage ?? l10n.slotsErrorSubtitle,
                      ),
                    ),
                  },
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _LoadingState extends StatelessWidget {
  const _LoadingState({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 28,
            height: 28,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Palette.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Text(message, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}
