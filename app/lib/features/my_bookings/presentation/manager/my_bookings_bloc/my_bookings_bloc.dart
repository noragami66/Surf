import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glina/features/my_bookings/application/i_my_bookings_service.dart';
import 'package:glina/features/my_bookings/domain/entities/booking_list_item_entity.dart';

part 'my_bookings_event.dart';
part 'my_bookings_state.dart';

class MyBookingsBloc extends Bloc<MyBookingsEvent, MyBookingsState> {
  MyBookingsBloc({required IMyBookingsService service})
    : _service = service,
      super(const MyBookingsState.initial()) {
    on<MyBookingsEvent>((event, emit) async {
      switch (event) {
        case LoadMyBookingsEvent(:final clientId):
        case RefreshMyBookingsEvent(:final clientId):
          await _onLoad(clientId, emit);
        case ResetMyBookingsEvent():
          emit(const MyBookingsState.initial());
      }
    });
  }

  final IMyBookingsService _service;

  Future<void> _onLoad(String clientId, Emitter<MyBookingsState> emit) async {
    emit(state.copyWith(status: MyBookingsStatus.loading));
    try {
      final items = await _service.listBookings(clientId);
      if (items.isEmpty) {
        emit(state.copyWith(status: MyBookingsStatus.empty, items: items));
        return;
      }
      emit(state.copyWith(status: MyBookingsStatus.loaded, items: items));
    } on Exception catch (error) {
      emit(
        state.copyWith(
          status: MyBookingsStatus.failure,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
