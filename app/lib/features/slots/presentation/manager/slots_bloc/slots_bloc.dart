import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glina/features/slots/application/i_slots_service.dart';
import 'package:glina/features/slots/domain/entities/slot_entity.dart';

part 'slots_event.dart';
part 'slots_state.dart';

class SlotsBloc extends Bloc<SlotsEvent, SlotsState> {
  SlotsBloc({required ISlotsService service})
    : _service = service,
      super(const SlotsState.initial()) {
    on<SlotsEvent>((event, emit) async {
      switch (event) {
        case LoadSlotsEvent():
        case RefreshSlotsEvent():
          await _onLoad(emit);
      }
    });
  }

  final ISlotsService _service;

  Future<void> _onLoad(Emitter<SlotsState> emit) async {
    emit(state.copyWith(status: SlotsStatus.loading));
    try {
      final slots = await _service.listSlots(const SlotsFilter());
      if (slots.isEmpty) {
        emit(state.copyWith(status: SlotsStatus.empty, slots: slots));
        return;
      }
      emit(state.copyWith(status: SlotsStatus.loaded, slots: slots));
    } on Exception catch (error) {
      emit(
        state.copyWith(
          status: SlotsStatus.failure,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
