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
