import 'package:flutter_test/flutter_test.dart';
import 'package:glina/features/booking/application/booking_service_impl.dart';
import 'package:glina/features/booking/data/repositories/booking_repository_mock.dart';
import 'package:glina/features/my_bookings/application/my_bookings_service_impl.dart';
import 'package:glina/features/slots/data/mock_slot_store.dart';
import 'package:glina/features/slots/data/repositories/slots_repository_mock.dart';

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
    );
  });

  test(
    'listBookings returns items for the authenticated client only',
    () async {
      final bookingService = BookingServiceImpl(
        repository: BookingRepositoryMock(store: store),
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
}
