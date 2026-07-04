/// Base application exception.
sealed class AppException implements Exception {
  const AppException(this.code, this.message);

  /// Machine-readable error code (matches api-contract error codes).
  final String code;

  /// Human-readable fallback message (UI prefers l10n by [code]).
  final String message;

  @override
  String toString() => message;
}

/// OTP code did not match (UC-5 E1).
final class InvalidCodeException extends AppException {
  const InvalidCodeException()
    : super('invalid_code', 'The confirmation code is incorrect');
}

/// Too many code requests in a short window (UC-5 E2).
final class RateLimitedException extends AppException {
  const RateLimitedException()
    : super('rate_limited', 'Too many attempts, please wait');
}

/// Refresh token expired — session must be dropped (UC-6 E1).
final class SessionExpiredException extends AppException {
  const SessionExpiredException()
    : super('refresh_expired', 'Session expired, please sign in again');
}

/// Generic network failure (UC-5/UC-6 E — offline).
final class NetworkException extends AppException {
  const NetworkException()
    : super('network_error', 'Network error, please try again');
}

/// Slot id was not found in the schedule.
final class SlotNotFoundException extends AppException {
  SlotNotFoundException(String slotId)
    : super('slot_not_found', 'Slot $slotId was not found');
}

/// Not enough seats or rental kits (UC-1 E1/E2).
final class SlotFullException extends AppException {
  const SlotFullException({
    required this.availableSeats,
    required this.availableRentalKits,
  }) : super('slot_full', 'Not enough seats or rental kits available');

  final int availableSeats;
  final int availableRentalKits;
}

/// Client already has an active booking for this slot (UC-1).
final class DoubleBookingException extends AppException {
  const DoubleBookingException()
    : super('double_booking', 'You already have a booking for this slot');
}

/// Slot was cancelled by the workshop (UC-1 E5).
final class SlotCancelledException extends AppException {
  const SlotCancelledException()
    : super('slot_cancelled', 'This workshop was cancelled');
}

/// Slot has already started — booking unavailable (UC-1 E5).
final class SlotStartedException extends AppException {
  const SlotStartedException()
    : super('slot_started', 'This workshop has already started');
}

/// seats_count outside 1..3 (application validation).
final class InvalidSeatsCountException extends AppException {
  const InvalidSeatsCountException()
    : super('invalid_seats_count', 'Choose between 1 and 3 seats');
}

/// rental_count > seats_count (application validation, UC-1).
final class InvalidRentalCountException extends AppException {
  const InvalidRentalCountException()
    : super('invalid_rental_count', 'Rental count cannot exceed seats count');
}

/// Idempotency-Key header is required (R-022).
final class InvalidIdempotencyKeyException extends AppException {
  const InvalidIdempotencyKeyException()
    : super('invalid_idempotency_key', 'Missing idempotency key');
}
