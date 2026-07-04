import 'package:glina/core/exception/app_exception.dart';
import 'package:glina/features/booking/application/i_booking_service.dart';
import 'package:glina/features/booking/domain/entities/booking_entity.dart';
import 'package:glina/features/booking/domain/repositories/i_booking_repository.dart';

/// Max seats per booking (R-013, UC-1).
const maxSeatsPerBooking = 3;

class BookingServiceImpl implements IBookingService {
  BookingServiceImpl({required IBookingRepository repository})
    : _repository = repository;

  final IBookingRepository _repository;

  @override
  Future<BookingEntity> createBooking({
    required String clientId,
    required String slotId,
    required int seatsCount,
    required int rentalCount,
    required String idempotencyKey,
  }) async {
    if (seatsCount < 1 || seatsCount > maxSeatsPerBooking) {
      throw const InvalidSeatsCountException();
    }
    if (rentalCount < 0 || rentalCount > seatsCount) {
      throw const InvalidRentalCountException();
    }
    if (idempotencyKey.trim().isEmpty) {
      throw const InvalidIdempotencyKeyException();
    }

    return _repository.createBooking(
      clientId: clientId,
      slotId: slotId,
      seatsCount: seatsCount,
      rentalCount: rentalCount,
      idempotencyKey: idempotencyKey,
    );
  }
}
