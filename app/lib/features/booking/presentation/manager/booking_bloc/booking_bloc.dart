import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glina/core/exception/app_exception.dart';
import 'package:glina/features/booking/application/i_booking_service.dart';
import 'package:glina/features/booking/domain/entities/booking_entity.dart';
import 'package:glina/features/slots/application/i_slots_service.dart';
import 'package:glina/features/slots/domain/entities/slot_entity.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc({
    required IBookingService bookingService,
    required ISlotsService slotsService,
    required String slotId,
    required String clientId,
  }) : _bookingService = bookingService,
       _slotsService = slotsService,
       _slotId = slotId,
       _clientId = clientId,
       super(const BookingState.initial()) {
    on<BookingEvent>((event, emit) async {
      switch (event) {
        case LoadBookingSlotEvent():
          await _onLoadSlot(emit);
        case BookingSeatsChanged(:final seatsCount):
          emit(
            state.copyWith(
              seatsCount: seatsCount,
              rentalCount: state.rentalCount.clamp(0, seatsCount),
            ),
          );
        case BookingRentalChanged(:final rentalCount):
          emit(state.copyWith(rentalCount: rentalCount));
        case SubmitBookingEvent():
          await _onSubmit(emit);
      }
    });
  }

  final IBookingService _bookingService;
  final ISlotsService _slotsService;
  final String _slotId;
  final String _clientId;
  final _random = Random();

  Future<void> _onLoadSlot(Emitter<BookingState> emit) async {
    emit(state.copyWith(status: BookingFormStatus.loading));
    try {
      final slot = await _slotsService.getSlot(_slotId);
      emit(
        state.copyWith(
          status: BookingFormStatus.editing,
          slot: slot,
          seatsCount: 1,
          rentalCount: 0,
        ),
      );
    } on AppException catch (error) {
      emit(
        state.copyWith(
          status: BookingFormStatus.failure,
          errorCode: error.code,
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          status: BookingFormStatus.failure,
          errorCode: 'network_error',
        ),
      );
    }
  }

  Future<void> _onSubmit(Emitter<BookingState> emit) async {
    final slot = state.slot;
    if (slot == null) {
      return;
    }

    final idempotencyKey = state.idempotencyKey ?? _newIdempotencyKey();
    emit(
      state.copyWith(
        status: BookingFormStatus.submitting,
        idempotencyKey: idempotencyKey,
      ),
    );

    try {
      final booking = await _bookingService.createBooking(
        clientId: _clientId,
        slotId: _slotId,
        seatsCount: state.seatsCount,
        rentalCount: state.rentalCount,
        idempotencyKey: idempotencyKey,
      );
      emit(state.copyWith(status: BookingFormStatus.success, booking: booking));
    } on AppException catch (error) {
      emit(
        state.copyWith(
          status: BookingFormStatus.editing,
          errorCode: error.code,
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          status: BookingFormStatus.editing,
          errorCode: 'network_error',
        ),
      );
    }
  }

  String _newIdempotencyKey() {
    final bytes = List<int>.generate(16, (_) => _random.nextInt(256));
    return bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  }
}
