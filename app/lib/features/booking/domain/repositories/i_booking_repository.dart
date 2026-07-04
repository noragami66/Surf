import 'package:glina/features/booking/domain/entities/booking_entity.dart';

abstract interface class IBookingRepository {
  Future<BookingEntity> createBooking({
    required String clientId,
    required String slotId,
    required int seatsCount,
    required int rentalCount,
    required String idempotencyKey,
  });

  Future<List<BookingEntity>> listBookings({required String clientId});
}
