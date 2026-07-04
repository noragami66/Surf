import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glina/core/exception/app_exception.dart';
import 'package:glina/features/slots/application/i_slots_service.dart';
import 'package:glina/features/slots/domain/entities/slot_entity.dart';
import 'package:glina/features/slots/domain/enums/slot_enums.dart';

part 'slot_detail_event.dart';
part 'slot_detail_state.dart';

class SlotDetailBloc extends Bloc<SlotDetailEvent, SlotDetailState> {
  SlotDetailBloc({required ISlotsService service, required String slotId})
    : _service = service,
      _slotId = slotId,
      super(const SlotDetailState.initial()) {
    on<SlotDetailEvent>((event, emit) async {
      switch (event) {
        case LoadSlotDetailEvent():
          await _onLoad(emit);
      }
    });
  }

  final ISlotsService _service;
  final String _slotId;

  Future<void> _onLoad(Emitter<SlotDetailState> emit) async {
    emit(state.copyWith(status: SlotDetailStatus.loading));
    try {
      final slot = await _service.getSlot(_slotId);
      emit(state.copyWith(status: SlotDetailStatus.loaded, slot: slot));
    } on SlotNotFoundException {
      emit(state.copyWith(status: SlotDetailStatus.notFound));
    } on AppException catch (error) {
      emit(
        state.copyWith(status: SlotDetailStatus.failure, errorCode: error.code),
      );
    } on Exception {
      emit(
        state.copyWith(
          status: SlotDetailStatus.failure,
          errorCode: 'network_error',
        ),
      );
    }
  }
}
