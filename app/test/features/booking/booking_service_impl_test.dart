import 'package:flutter_test/flutter_test.dart';
import 'package:glina/core/exception/app_exception.dart';
import 'package:glina/features/booking/application/booking_service_impl.dart';
import 'package:glina/features/booking/data/repositories/booking_repository_mock.dart';
import 'package:glina/features/slots/data/mock_slot_store.dart';

void main() {
  const clientId = 'client-1';
  const slotId = 'slot-1';
  const idempotencyKey = 'test-key-1';

  late MockSlotStore store;
  late BookingServiceImpl service;

  setUp(() {
    store = MockSlotStore.instance..reset();
    service = BookingServiceImpl(
      repository: BookingRepositoryMock(store: store),
    );
  });

  group('BookingServiceImpl', () {
    test('createBooking succeeds and returns price_total', () async {
      final booking = await service.createBooking(
        clientId: clientId,
        slotId: slotId,
        seatsCount: 2,
        rentalCount: 1,
        idempotencyKey: idempotencyKey,
      );

      expect(booking.seatsCount, 2);
      expect(booking.rentalCount, 1);
      expect(booking.priceTotal, greaterThan(0));
      expect(store.slots.first.freeSeats, 1);
    });

    test('rejects rental_count greater than seats_count', () {
      expect(
        () => service.createBooking(
          clientId: clientId,
          slotId: slotId,
          seatsCount: 1,
          rentalCount: 2,
          idempotencyKey: idempotencyKey,
        ),
        throwsA(isA<InvalidRentalCountException>()),
      );
    });

    test('rejects seats_count outside 1..3', () {
      expect(
        () => service.createBooking(
          clientId: clientId,
          slotId: slotId,
          seatsCount: 4,
          rentalCount: 0,
          idempotencyKey: idempotencyKey,
        ),
        throwsA(isA<InvalidSeatsCountException>()),
      );
    });

    test('returns cached booking for the same idempotency key', () async {
      final first = await service.createBooking(
        clientId: clientId,
        slotId: slotId,
        seatsCount: 1,
        rentalCount: 0,
        idempotencyKey: idempotencyKey,
      );

      final second = await service.createBooking(
        clientId: clientId,
        slotId: slotId,
        seatsCount: 1,
        rentalCount: 0,
        idempotencyKey: idempotencyKey,
      );

      expect(second.id, first.id);
      expect(store.bookings.length, 1);
    });

    test('throws double_booking for the same client and slot', () async {
      await service.createBooking(
        clientId: clientId,
        slotId: slotId,
        seatsCount: 1,
        rentalCount: 0,
        idempotencyKey: idempotencyKey,
      );

      expect(
        () => service.createBooking(
          clientId: clientId,
          slotId: slotId,
          seatsCount: 1,
          rentalCount: 0,
          idempotencyKey: 'another-key',
        ),
        throwsA(isA<DoubleBookingException>()),
      );
    });
  });
}
