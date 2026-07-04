import 'package:flutter_test/flutter_test.dart';
import 'package:glina/features/booking/application/booking_service_impl.dart';
import 'package:glina/features/booking/data/repositories/booking_repository_mock.dart';
import 'package:glina/features/booking/domain/enums/booking_enums.dart';
import 'package:glina/features/my_bookings/application/my_bookings_service_impl.dart';
import 'package:glina/features/slots/data/mock_slot_store.dart';
import 'package:glina/features/slots/data/repositories/slots_repository_mock.dart';

import '../../support/mock_auth_service.dart';

void main() {
  const clientId = 'client-1';
  const otherClientId = 'client-2';
  const slotId = 'slot-1';
  const idempotencyKey = 'list-test-key';

  late MockSlotStore store;
  late MyBookingsServiceImpl service;

  setUp(() {
    store = MockSlotStore.instance..reset();
    final bookingRepo = BookingRepositoryMock(store: store);
    service = MyBookingsServiceImpl(
      bookingRepository: bookingRepo,
      slotsRepository: SlotsRepositoryMock(store: store),
      authService: stubAuthService(),
    );
  });

  test(
    'listBookings returns items for the authenticated client only',
    () async {
      final bookingService = BookingServiceImpl(
        repository: BookingRepositoryMock(store: store),
        authService: stubAuthService(),
      );

      await bookingService.createBooking(
        clientId: clientId,
        slotId: slotId,
        seatsCount: 1,
        rentalCount: 0,
        idempotencyKey: idempotencyKey,
      );

      await bookingService.createBooking(
        clientId: otherClientId,
        slotId: slotId,
        seatsCount: 1,
        rentalCount: 0,
        idempotencyKey: 'other-key',
      );

      final items = await service.listBookings(clientId);

      expect(items, hasLength(1));
      expect(items.first.booking.clientId, clientId);
      expect(items.first.slot.id, slotId);
    },
  );

  test('listBookings returns empty list when client has no bookings', () async {
    expect(await service.listBookings(clientId), isEmpty);
  });

  test('cancelBooking early cancel restores slot seats', () async {
    final bookingRepo = BookingRepositoryMock(store: store);
    final bookingService = BookingServiceImpl(
      repository: bookingRepo,
      authService: stubAuthService(),
    );
    service = MyBookingsServiceImpl(
      bookingRepository: bookingRepo,
      slotsRepository: SlotsRepositoryMock(store: store),
      authService: stubAuthService(),
    );

    final freeBefore = store.slots.first.freeSeats;

    final created = await bookingService.createBooking(
      clientId: clientId,
      slotId: slotId,
      seatsCount: 1,
      rentalCount: 0,
      idempotencyKey: idempotencyKey,
    );

    expect(store.slots.first.freeSeats, freeBefore - 1);

    final cancelled = await service.cancelBooking(
      bookingId: created.id,
      clientId: clientId,
    );

    expect(cancelled.booking.status, BookingStatus.cancelled);
    expect(store.slots.first.freeSeats, freeBefore);
  });
}
