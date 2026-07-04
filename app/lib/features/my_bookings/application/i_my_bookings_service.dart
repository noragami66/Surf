import 'package:glina/features/my_bookings/domain/entities/booking_list_item_entity.dart';

// Cancel use case arrives in stage 6; list only for now.
// ignore: one_member_abstracts
abstract interface class IMyBookingsService {
  Future<List<BookingListItemEntity>> listBookings(String clientId);
}
