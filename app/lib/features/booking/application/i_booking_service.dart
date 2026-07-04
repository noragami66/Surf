import 'package:glina/features/booking/domain/entities/booking_entity.dart';

// MVP booking slice exposes a single use case; list/cancel live in my_bookings.
// ignore: one_member_abstracts
abstract interface class IBookingService {
  Future<BookingEntity> createBooking({
    required String clientId,
    required String slotId,
    required int seatsCount,
    required int rentalCount,
    required String idempotencyKey,
  });
}
