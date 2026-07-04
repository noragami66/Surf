part of 'slots_bloc.dart';

sealed class SlotsEvent extends Equatable {
  const SlotsEvent();
}

final class LoadSlotsEvent extends SlotsEvent {
  const LoadSlotsEvent();

  @override
  List<Object?> get props => [];
}

final class RefreshSlotsEvent extends SlotsEvent {
  const RefreshSlotsEvent();

  @override
  List<Object?> get props => [];
}

final class ApplySlotsFilterEvent extends SlotsEvent {
  const ApplySlotsFilterEvent(this.filter);

  final SlotsFilter filter;

  @override
  List<Object?> get props => [filter];
}

final class ClearSlotsFiltersEvent extends SlotsEvent {
  const ClearSlotsFiltersEvent();

  @override
  List<Object?> get props => [];
}

final class ToggleProgramTypeFilterEvent extends SlotsEvent {
  const ToggleProgramTypeFilterEvent(this.type);

  final ProgramType type;

  @override
  List<Object?> get props => [type];
}

final class ToggleMasterFilterEvent extends SlotsEvent {
  const ToggleMasterFilterEvent(this.masterId);

  final String masterId;

  @override
  List<Object?> get props => [masterId];
}

final class ToggleOnlyAvailableFilterEvent extends SlotsEvent {
  const ToggleOnlyAvailableFilterEvent();

  @override
  List<Object?> get props => [];
}
