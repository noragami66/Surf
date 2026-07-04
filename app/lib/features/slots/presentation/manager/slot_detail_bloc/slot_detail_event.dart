part of 'slot_detail_bloc.dart';

sealed class SlotDetailEvent extends Equatable {
  const SlotDetailEvent();

  @override
  List<Object?> get props => [];
}

final class LoadSlotDetailEvent extends SlotDetailEvent {
  const LoadSlotDetailEvent();
}
