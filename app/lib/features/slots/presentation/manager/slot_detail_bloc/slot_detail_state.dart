part of 'slot_detail_bloc.dart';

enum SlotDetailStatus { initial, loading, loaded, notFound, failure }

class SlotDetailState extends Equatable {
  const SlotDetailState({required this.status, this.slot, this.errorCode});

  const SlotDetailState.initial()
    : status = SlotDetailStatus.initial,
      slot = null,
      errorCode = null;

  final SlotDetailStatus status;
  final SlotEntity? slot;
  final String? errorCode;

  bool get canBook =>
      slot != null &&
      slot!.status == SlotStatus.scheduled &&
      slot!.freeSeats > 0 &&
      slot!.startAt.isAfter(DateTime.now());

  SlotDetailState copyWith({
    SlotDetailStatus? status,
    SlotEntity? slot,
    String? errorCode,
  }) {
    return SlotDetailState(
      status: status ?? this.status,
      slot: slot ?? this.slot,
      errorCode: errorCode,
    );
  }

  @override
  List<Object?> get props => [status, slot, errorCode];
}
