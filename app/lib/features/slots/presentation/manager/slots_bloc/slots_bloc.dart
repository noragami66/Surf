import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glina/features/slots/application/i_slots_service.dart';
import 'package:glina/features/slots/domain/entities/slot_entity.dart';
import 'package:glina/features/slots/domain/enums/slot_enums.dart';

part 'slots_event.dart';
part 'slots_state.dart';

class SlotsBloc extends Bloc<SlotsEvent, SlotsState> {
  SlotsBloc({required ISlotsService service})
    : _service = service,
      super(SlotsState.initial()) {
    on<SlotsEvent>((event, emit) async {
      switch (event) {
        case LoadSlotsEvent():
        case RefreshSlotsEvent():
          await _onLoad(emit);
        case ApplySlotsFilterEvent(:final filter):
          emit(state.copyWith(filter: filter));
          await _onLoad(emit);
        case ClearSlotsFiltersEvent():
          emit(state.copyWith(filter: SlotsFilter.defaultWeek()));
          await _onLoad(emit);
        case ToggleProgramTypeFilterEvent(:final type):
          await _onToggleProgramType(type, emit);
        case ToggleMasterFilterEvent(:final masterId):
          await _onToggleMaster(masterId, emit);
        case ToggleOnlyAvailableFilterEvent():
          emit(
            state.copyWith(
              filter: state.filter.copyWith(
                onlyAvailable: !state.filter.onlyAvailable,
              ),
            ),
          );
          await _onLoad(emit);
      }
    });
  }

  final ISlotsService _service;

  Future<void> _onToggleProgramType(
    ProgramType type,
    Emitter<SlotsState> emit,
  ) async {
    final types = List<ProgramType>.from(state.filter.programTypes);
    if (types.contains(type)) {
      types.remove(type);
    } else {
      types.add(type);
    }
    emit(state.copyWith(filter: state.filter.copyWith(programTypes: types)));
    await _onLoad(emit);
  }

  Future<void> _onToggleMaster(
    String masterId,
    Emitter<SlotsState> emit,
  ) async {
    final ids = List<String>.from(state.filter.masterIds);
    if (ids.contains(masterId)) {
      ids.remove(masterId);
    } else {
      ids.add(masterId);
    }
    emit(state.copyWith(filter: state.filter.copyWith(masterIds: ids)));
    await _onLoad(emit);
  }

  Future<void> _onLoad(Emitter<SlotsState> emit) async {
    emit(state.copyWith(status: SlotsStatus.loading));
    try {
      final masters = state.masters.isEmpty
          ? await _service.listMasters()
          : state.masters;
      final slots = await _service.listSlots(state.filter);
      if (slots.isEmpty) {
        emit(
          state.copyWith(
            status: SlotsStatus.empty,
            slots: slots,
            masters: masters,
          ),
        );
        return;
      }
      emit(
        state.copyWith(
          status: SlotsStatus.loaded,
          slots: slots,
          masters: masters,
        ),
      );
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
