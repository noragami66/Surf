import 'package:flutter_test/flutter_test.dart';
import 'package:glina/core/constants/app_config_mock.dart';
import 'package:glina/features/booking/application/booking_service_impl.dart';
import 'package:glina/features/booking/data/repositories/booking_repository_mock.dart';
import 'package:glina/features/booking/domain/enums/booking_enums.dart';
import 'package:glina/features/slots/data/mock_slot_store.dart';
import 'package:glina/features/slots/domain/entities/slot_entity.dart';

void main() {
  const clientId = 'client-1';

  late MockSlotStore store;
  late BookingRepositoryMock repository;
  late BookingServiceImpl service;

  setUp(() {
    store = MockSlotStore.instance..reset();
    repository = BookingRepositoryMock(store: store);
    service = BookingServiceImpl(repository: repository);
  });

  void setSlotStart(int index, DateTime startAt) {
    final slot = store.slots[index];
    store.updateSlot(
      index,
      SlotEntity(
        id: slot.id,
        program: slot.program,
        master: slot.master,
        startAt: startAt,
        totalSeats: slot.totalSeats,
        freeSeats: slot.freeSeats,
        freeRentalKits: slot.freeRentalKits,
        priceAmount: slot.priceAmount,
        rentalPriceAmount: slot.rentalPriceAmount,
        workshopAddress: slot.workshopAddress,
        status: slot.status,
      ),
    );
  }

  test('getBooking returns booking for owner', () async {
    final created = await service.createBooking(
      clientId: clientId,
      slotId: 'slot-1',
      seatsCount: 1,
      rentalCount: 0,
      idempotencyKey: 'k1',
    );

    final fetched = await repository.getBooking(
      bookingId: created.id,
      clientId: clientId,
    );

    expect(fetched.id, created.id);
  });

  test(
    'early cancel restores seats when outside cancellation window',
    () async {
      setSlotStart(
        0,
        DateTime.now().add(
          const Duration(minutes: AppConfigMock.cancellationWindowMinutes + 30),
        ),
      );

      final created = await service.createBooking(
        clientId: clientId,
        slotId: 'slot-1',
        seatsCount: 1,
        rentalCount: 0,
        idempotencyKey: 'k2',
      );

      final freeAfterBook = store.slots.first.freeSeats;

      final cancelled = await repository.cancelBooking(
        bookingId: created.id,
        clientId: clientId,
      );

      expect(cancelled.status, BookingStatus.cancelled);
      expect(store.slots.first.freeSeats, freeAfterBook + 1);
    },
  );

  test(
    'late cancel does not restore seats inside cancellation window',
    () async {
      setSlotStart(
        0,
        DateTime.now().add(
          const Duration(minutes: AppConfigMock.cancellationWindowMinutes - 30),
        ),
      );

      final created = await service.createBooking(
        clientId: clientId,
        slotId: 'slot-1',
        seatsCount: 1,
        rentalCount: 0,
        idempotencyKey: 'k3',
      );

      final freeAfterBook = store.slots.first.freeSeats;

      final cancelled = await repository.cancelBooking(
        bookingId: created.id,
        clientId: clientId,
      );

      expect(cancelled.status, BookingStatus.lateCancel);
      expect(store.slots.first.freeSeats, freeAfterBook);
    },
  );

  test('early cancel at 121m30s is not truncated to late cancel', () async {
    setSlotStart(
      0,
      DateTime.now().add(const Duration(minutes: 121, seconds: 30)),
    );

    final created = await service.createBooking(
      clientId: clientId,
      slotId: 'slot-1',
      seatsCount: 1,
      rentalCount: 0,
      idempotencyKey: 'k4',
    );

    final cancelled = await repository.cancelBooking(
      bookingId: created.id,
      clientId: clientId,
    );

    expect(cancelled.status, BookingStatus.cancelled);
  });
}
