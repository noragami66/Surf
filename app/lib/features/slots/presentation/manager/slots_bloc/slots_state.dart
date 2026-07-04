part of 'slots_bloc.dart';

enum SlotsStatus { initial, loading, loaded, empty, failure }

final class SlotsState extends Equatable {
  const SlotsState({
    required this.status,
    this.slots = const [],
    this.errorMessage,
  });

  const SlotsState.initial() : this(status: SlotsStatus.initial);

  final SlotsStatus status;
  final List<SlotEntity> slots;
  final String? errorMessage;

  SlotsState copyWith({
    SlotsStatus? status,
    List<SlotEntity>? slots,
    String? errorMessage,
  }) {
    return SlotsState(
      status: status ?? this.status,
      slots: slots ?? this.slots,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, slots, errorMessage];
}
