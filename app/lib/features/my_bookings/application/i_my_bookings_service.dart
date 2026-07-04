import 'package:glina/features/my_bookings/domain/entities/booking_list_item_entity.dart';

// Cancel arrives in the same service as list/detail (stage 6).
abstract interface class IMyBookingsService {
  Future<List<BookingListItemEntity>> listBookings(String clientId);

  Future<BookingListItemEntity> getBooking({
    required String bookingId,
    required String clientId,
  });

  Future<BookingListItemEntity> cancelBooking({
    required String bookingId,
    required String clientId,
  });
}
