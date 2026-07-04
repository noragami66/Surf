import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glina/features/booking/domain/entities/booking_entity.dart';
import 'package:glina/features/booking/domain/enums/booking_enums.dart';
import 'package:glina/features/my_bookings/application/i_my_bookings_service.dart';
import 'package:glina/features/my_bookings/domain/entities/booking_list_item_entity.dart';
import 'package:glina/features/my_bookings/presentation/manager/booking_detail_bloc/booking_detail_bloc.dart';
import 'package:glina/features/slots/domain/entities/slot_entity.dart';
import 'package:glina/features/slots/domain/enums/slot_enums.dart';
import 'package:mocktail/mocktail.dart';

class _MockMyBookingsService extends Mock implements IMyBookingsService {}

void main() {
  const bookingId = 'b1';
  const clientId = 'client-1';

  final item = BookingListItemEntity(
    booking: BookingEntity(
      id: bookingId,
      slotId: 'slot-1',
      clientId: clientId,
      seatsCount: 1,
      rentalCount: 0,
      status: BookingStatus.active,
      priceTotal: 1000,
      createdAt: DateTime.now(),
    ),
    slot: SlotEntity(
      id: 'slot-1',
      program: const ProgramEntity(
        id: 'p1',
        name: 'Test',
        type: ProgramType.handbuilding,
        capacityCap: 6,
        durationMin: 120,
      ),
      master: const MasterEntity(id: 'm1', name: 'Anna'),
      startAt: DateTime.now().add(const Duration(days: 1)),
      totalSeats: 6,
      freeSeats: 2,
      freeRentalKits: 3,
      priceAmount: 1000,
      rentalPriceAmount: 100,
      workshopAddress: 'Addr',
      status: SlotStatus.scheduled,
    ),
  );

  late IMyBookingsService service;

  setUp(() => service = _MockMyBookingsService());

  blocTest<BookingDetailBloc, BookingDetailState>(
    'emits loaded on LoadBookingDetailEvent',
    setUp: () => when(
      () => service.getBooking(bookingId: bookingId, clientId: clientId),
    ).thenAnswer((_) async => item),
    build: () => BookingDetailBloc(
      service: service,
      bookingId: bookingId,
      clientId: clientId,
    ),
    act: (bloc) => bloc.add(const LoadBookingDetailEvent()),
    expect: () => [
      isA<BookingDetailState>().having(
        (s) => s.status,
        'status',
        BookingDetailStatus.loading,
      ),
      isA<BookingDetailState>().having(
        (s) => s.status,
        'status',
        BookingDetailStatus.loaded,
      ),
    ],
  );

  blocTest<BookingDetailBloc, BookingDetailState>(
    'emits cancelled after successful cancel',
    setUp: () {
      when(
        () => service.getBooking(bookingId: bookingId, clientId: clientId),
      ).thenAnswer((_) async => item);
      when(
        () => service.cancelBooking(bookingId: bookingId, clientId: clientId),
      ).thenAnswer(
        (_) async => BookingListItemEntity(
          booking: item.booking.copyWith(
            status: BookingStatus.cancelled,
            cancelledAt: DateTime.now(),
          ),
          slot: item.slot,
        ),
      );
    },
    build: () => BookingDetailBloc(
      service: service,
      bookingId: bookingId,
      clientId: clientId,
    ),
    seed: () =>
        BookingDetailState(status: BookingDetailStatus.loaded, item: item),
    act: (bloc) => bloc.add(const CancelBookingEvent()),
    expect: () => [
      isA<BookingDetailState>().having(
        (s) => s.status,
        'status',
        BookingDetailStatus.cancelling,
      ),
      isA<BookingDetailState>().having(
        (s) => s.status,
        'status',
        BookingDetailStatus.cancelled,
      ),
    ],
  );
}
