import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glina/core/style/palette.dart';
import 'package:glina/core/widgets/glass_container.dart';
import 'package:glina/features/slots/presentation/manager/slots_bloc/slots_bloc.dart';
import 'package:glina/features/slots/presentation/widgets/slot_card.dart';
import 'package:glina/l10n/app_localizations.dart';

class SlotListScreen extends StatelessWidget {
  const SlotListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<SlotsBloc, SlotsState>(
          builder: (context, state) {
            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.appTitle,
                          style: theme.textTheme.headlineLarge,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          l10n.appTagline,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: Palette.textMuted,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                    child: Text(
                      l10n.slotsSectionTitle,
                      style: theme.textTheme.headlineSmall,
                    ),
                  ),
                ),
                switch (state.status) {
                  SlotsStatus.initial || SlotsStatus.loading =>
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: _LoadingState(message: l10n.loading),
                    ),
                  SlotsStatus.empty => SliverFillRemaining(
                    hasScrollBody: false,
                    child: _EmptyState(
                      title: l10n.slotsEmptyTitle,
                      subtitle: l10n.slotsEmptySubtitle,
                    ),
                  ),
                  SlotsStatus.loaded => SliverPadding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 120),
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
                    child: _EmptyState(
                      title: l10n.slotsErrorTitle,
                      subtitle: state.errorMessage ?? l10n.slotsErrorSubtitle,
                    ),
                  ),
                },
              ],
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
      child: GlassContainer(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 28,
              height: 28,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Palette.ember,
              ),
            ),
            const SizedBox(height: 16),
            Text(message, style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Center(
        child: GlassContainer(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 36),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Palette.ember.withValues(alpha: 0.35),
                      Palette.ember.withValues(alpha: 0.05),
                    ],
                  ),
                  border: Border.all(color: Palette.glassBorder),
                ),
                child: const Icon(
                  Icons.calendar_month_outlined,
                  color: Palette.ember,
                  size: 32,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                title,
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineSmall?.copyWith(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
