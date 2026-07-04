import 'package:glina/features/booking/domain/repositories/i_booking_repository.dart';
import 'package:glina/features/my_bookings/application/i_my_bookings_service.dart';
import 'package:glina/features/my_bookings/domain/entities/booking_list_item_entity.dart';
import 'package:glina/features/slots/domain/repositories/i_slots_repository.dart';

class MyBookingsServiceImpl implements IMyBookingsService {
  MyBookingsServiceImpl({
    required IBookingRepository bookingRepository,
    required ISlotsRepository slotsRepository,
  }) : _bookingRepository = bookingRepository,
       _slotsRepository = slotsRepository;

  final IBookingRepository _bookingRepository;
  final ISlotsRepository _slotsRepository;

  @override
  Future<List<BookingListItemEntity>> listBookings(String clientId) async {
    final bookings = await _bookingRepository.listBookings(clientId: clientId);

    final items = <BookingListItemEntity>[];
    for (final booking in bookings) {
      final slot = await _slotsRepository.getSlot(booking.slotId);
      items.add(BookingListItemEntity(booking: booking, slot: slot));
    }

    items.sort((a, b) => a.slot.startAt.compareTo(b.slot.startAt));
    return items;
  }
}
