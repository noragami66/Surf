import 'package:glina/features/auth/application/i_auth_service.dart';
import 'package:glina/features/booking/domain/entities/booking_entity.dart';
import 'package:glina/features/booking/domain/repositories/i_booking_repository.dart';
import 'package:glina/features/my_bookings/application/i_my_bookings_service.dart';
import 'package:glina/features/my_bookings/domain/entities/booking_list_item_entity.dart';
import 'package:glina/features/slots/domain/repositories/i_slots_repository.dart';

class MyBookingsServiceImpl implements IMyBookingsService {
  MyBookingsServiceImpl({
    required IBookingRepository bookingRepository,
    required ISlotsRepository slotsRepository,
    required IAuthService authService,
  }) : _bookingRepository = bookingRepository,
       _slotsRepository = slotsRepository,
       _authService = authService;

  final IBookingRepository _bookingRepository;
  final ISlotsRepository _slotsRepository;
  final IAuthService _authService;

  @override
  Future<List<BookingListItemEntity>> listBookings(String clientId) async {
    await _authService.ensureValidSession();
    final bookings = await _bookingRepository.listBookings(clientId: clientId);
    return _enrich(bookings);
  }

  @override
  Future<BookingListItemEntity> getBooking({
    required String bookingId,
    required String clientId,
  }) async {
    await _authService.ensureValidSession();
    final booking = await _bookingRepository.getBooking(
      bookingId: bookingId,
      clientId: clientId,
    );
    final slot = await _slotsRepository.getSlot(booking.slotId);
    return BookingListItemEntity(booking: booking, slot: slot);
  }

  @override
  Future<BookingListItemEntity> cancelBooking({
    required String bookingId,
    required String clientId,
  }) async {
    await _authService.ensureValidSession();
    final booking = await _bookingRepository.cancelBooking(
      bookingId: bookingId,
      clientId: clientId,
    );
    final slot = await _slotsRepository.getSlot(booking.slotId);
    return BookingListItemEntity(booking: booking, slot: slot);
  }

  Future<List<BookingListItemEntity>> _enrich(
    List<BookingEntity> bookings,
  ) async {
    final items = <BookingListItemEntity>[];
    for (final booking in bookings) {
      final slot = await _slotsRepository.getSlot(booking.slotId);
      items.add(BookingListItemEntity(booking: booking, slot: slot));
    }
    items.sort((a, b) => a.slot.startAt.compareTo(b.slot.startAt));
    return items;
  }
}
