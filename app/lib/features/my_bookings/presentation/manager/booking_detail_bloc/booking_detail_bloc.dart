import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glina/core/exception/app_exception.dart';
import 'package:glina/features/my_bookings/application/i_my_bookings_service.dart';
import 'package:glina/features/my_bookings/domain/entities/booking_list_item_entity.dart';

part 'booking_detail_event.dart';
part 'booking_detail_state.dart';

class BookingDetailBloc extends Bloc<BookingDetailEvent, BookingDetailState> {
  BookingDetailBloc({
    required IMyBookingsService service,
    required String bookingId,
    required String clientId,
  }) : _service = service,
       _bookingId = bookingId,
       _clientId = clientId,
       super(const BookingDetailState.initial()) {
    on<BookingDetailEvent>((event, emit) async {
      switch (event) {
        case LoadBookingDetailEvent():
          await _onLoad(emit);
        case CancelBookingEvent():
          await _onCancel(emit);
      }
    });
  }

  final IMyBookingsService _service;
  final String _bookingId;
  final String _clientId;

  Future<void> _onLoad(Emitter<BookingDetailState> emit) async {
    emit(state.copyWith(status: BookingDetailStatus.loading));
    try {
      final item = await _service.getBooking(
        bookingId: _bookingId,
        clientId: _clientId,
      );
      emit(state.copyWith(status: BookingDetailStatus.loaded, item: item));
    } on AppException catch (error) {
      emit(
        state.copyWith(
          status: BookingDetailStatus.failure,
          errorCode: error.code,
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          status: BookingDetailStatus.failure,
          errorCode: 'network_error',
        ),
      );
    }
  }

  Future<void> _onCancel(Emitter<BookingDetailState> emit) async {
    emit(state.copyWith(status: BookingDetailStatus.cancelling));
    try {
      final item = await _service.cancelBooking(
        bookingId: _bookingId,
        clientId: _clientId,
      );
      emit(state.copyWith(status: BookingDetailStatus.cancelled, item: item));
    } on AppException catch (error) {
      emit(
        state.copyWith(
          status: BookingDetailStatus.loaded,
          errorCode: error.code,
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          status: BookingDetailStatus.loaded,
          errorCode: 'network_error',
        ),
      );
    }
  }
}
