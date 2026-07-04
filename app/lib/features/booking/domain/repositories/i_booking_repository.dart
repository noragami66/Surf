import 'package:glina/features/booking/domain/entities/booking_entity.dart';

// createBooking only in stage 5; list/cancel methods added in stage 6.
// ignore: one_member_abstracts
abstract interface class IBookingRepository {
  Future<BookingEntity> createBooking({
    required String clientId,
    required String slotId,
    required int seatsCount,
    required int rentalCount,
    required String idempotencyKey,
  });
}
