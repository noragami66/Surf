part of 'slots_bloc.dart';

enum SlotsStatus { initial, loading, loaded, empty, failure }

final class SlotsState extends Equatable {
  const SlotsState({
    required this.status,
    required this.filter,
    this.slots = const [],
    this.masters = const [],
    this.errorMessage,
  });

  factory SlotsState.initial() => SlotsState(
    status: SlotsStatus.initial,
    filter: SlotsFilter.defaultWeek(),
  );

  final SlotsStatus status;
  final List<SlotEntity> slots;
  final List<MasterEntity> masters;
  final SlotsFilter filter;
  final String? errorMessage;

  bool get isEmptyDueToFilters =>
      status == SlotsStatus.empty && filter.hasActiveFilters;

  SlotsState copyWith({
    SlotsStatus? status,
    List<SlotEntity>? slots,
    List<MasterEntity>? masters,
    SlotsFilter? filter,
    String? errorMessage,
  }) {
    return SlotsState(
      status: status ?? this.status,
      slots: slots ?? this.slots,
      masters: masters ?? this.masters,
      filter: filter ?? this.filter,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, slots, masters, filter, errorMessage];
}
