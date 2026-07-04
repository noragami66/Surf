import 'package:glina/core/constants/app_config_mock.dart';
import 'package:glina/core/exception/app_exception.dart';
import 'package:glina/features/booking/domain/entities/booking_entity.dart';
import 'package:glina/features/booking/domain/enums/booking_enums.dart';
import 'package:glina/features/booking/domain/repositories/i_booking_repository.dart';
import 'package:glina/features/slots/data/mock_slot_store.dart';
import 'package:glina/features/slots/domain/entities/slot_entity.dart';
import 'package:glina/features/slots/domain/enums/slot_enums.dart';

/// In-memory booking mock with shared slot inventory (UC-1, api-contract).
class BookingRepositoryMock implements IBookingRepository {
  BookingRepositoryMock({MockSlotStore? store})
    : _store = store ?? MockSlotStore.instance;

  final MockSlotStore _store;
  static const _latency = Duration(milliseconds: 350);

  var _bookingSeq = 0;

  @override
  Future<BookingEntity> createBooking({
    required String clientId,
    required String slotId,
    required int seatsCount,
    required int rentalCount,
    required String idempotencyKey,
  }) async {
    await Future<void>.delayed(_latency);

    final cached = _store.idempotencyKeys[idempotencyKey];
    if (cached != null) {
      return cached;
    }

    final index = _store.slotIndex(slotId);
    if (index < 0) {
      throw SlotNotFoundException(slotId);
    }

    final slot = _store.slots[index];

    if (slot.status == SlotStatus.cancelled) {
      throw const SlotCancelledException();
    }
    if (!slot.startAt.isAfter(DateTime.now())) {
      throw const SlotStartedException();
    }

    final hasActive = _store.bookings.any(
      (b) =>
          b.clientId == clientId &&
          b.slotId == slotId &&
          b.status == BookingStatus.active,
    );
    if (hasActive) {
      throw const DoubleBookingException();
    }

    if (seatsCount > slot.freeSeats || rentalCount > slot.freeRentalKits) {
      throw SlotFullException(
        availableSeats: slot.freeSeats,
        availableRentalKits: slot.freeRentalKits,
      );
    }

    _bookingSeq++;
    final priceTotal =
        slot.priceAmount * seatsCount + slot.rentalPriceAmount * rentalCount;

    final booking = BookingEntity(
      id: 'booking-$_bookingSeq',
      slotId: slotId,
      clientId: clientId,
      seatsCount: seatsCount,
      rentalCount: rentalCount,
      status: BookingStatus.active,
      priceTotal: priceTotal,
      createdAt: DateTime.now(),
    );

    _store.bookings.add(booking);
    _store.idempotencyKeys[idempotencyKey] = booking;
    _store.updateSlot(index, _decrementSlot(slot, seatsCount, rentalCount));

    return booking;
  }

  @override
  Future<List<BookingEntity>> listBookings({required String clientId}) async {
    await Future<void>.delayed(_latency);
    return _store.bookings
        .where((booking) => booking.clientId == clientId)
        .toList(growable: false);
  }

  @override
  Future<BookingEntity> getBooking({
    required String bookingId,
    required String clientId,
  }) async {
    await Future<void>.delayed(_latency);
    final booking = _findBooking(bookingId, clientId);
    if (booking == null) {
      throw const BookingNotFoundException();
    }
    return booking;
  }

  @override
  Future<BookingEntity> cancelBooking({
    required String bookingId,
    required String clientId,
  }) async {
    await Future<void>.delayed(_latency);

    final index = _bookingIndex(bookingId);
    if (index < 0) {
      throw const BookingNotFoundException();
    }

    final booking = _store.bookings[index];
    if (booking.clientId != clientId) {
      throw const BookingNotFoundException();
    }
    if (booking.status != BookingStatus.active) {
      throw const BookingAlreadyCancelledException();
    }

    final slotIndex = _store.slotIndex(booking.slotId);
    if (slotIndex < 0) {
      throw const BookingNotFoundException();
    }

    final slot = _store.slots[slotIndex];
    if (!slot.startAt.isAfter(DateTime.now())) {
      throw const BookingCancelSlotStartedException();
    }

    final minutesUntilStart = slot.startAt.difference(DateTime.now());
    final isEarlyCancel =
        minutesUntilStart >=
        const Duration(minutes: AppConfigMock.cancellationWindowMinutes);
    final newStatus = isEarlyCancel
        ? BookingStatus.cancelled
        : BookingStatus.lateCancel;

    final updated = booking.copyWith(
      status: newStatus,
      cancelledAt: DateTime.now(),
    );
    _store.bookings[index] = updated;

    if (isEarlyCancel) {
      _store.updateSlot(
        slotIndex,
        _incrementSlot(slot, booking.seatsCount, booking.rentalCount),
      );
    }

    return updated;
  }

  BookingEntity? _findBooking(String bookingId, String clientId) {
    for (final booking in _store.bookings) {
      if (booking.id == bookingId && booking.clientId == clientId) {
        return booking;
      }
    }
    return null;
  }

  int _bookingIndex(String bookingId) =>
      _store.bookings.indexWhere((b) => b.id == bookingId);

  SlotEntity _decrementSlot(SlotEntity slot, int seatsCount, int rentalCount) {
    return SlotEntity(
      id: slot.id,
      program: slot.program,
      master: slot.master,
      startAt: slot.startAt,
      totalSeats: slot.totalSeats,
      freeSeats: slot.freeSeats - seatsCount,
      freeRentalKits: slot.freeRentalKits - rentalCount,
      priceAmount: slot.priceAmount,
      rentalPriceAmount: slot.rentalPriceAmount,
      workshopAddress: slot.workshopAddress,
      status: slot.status,
    );
  }

  SlotEntity _incrementSlot(SlotEntity slot, int seatsCount, int rentalCount) {
    return SlotEntity(
      id: slot.id,
      program: slot.program,
      master: slot.master,
      startAt: slot.startAt,
      totalSeats: slot.totalSeats,
      freeSeats: (slot.freeSeats + seatsCount).clamp(0, slot.totalSeats),
      freeRentalKits: slot.freeRentalKits + rentalCount,
      priceAmount: slot.priceAmount,
      rentalPriceAmount: slot.rentalPriceAmount,
      workshopAddress: slot.workshopAddress,
      status: slot.status,
    );
  }
}
