part of 'booking_bloc.dart';

enum BookingFormStatus {
  initial,
  loading,
  editing,
  submitting,
  success,
  failure,
}

class BookingState extends Equatable {
  const BookingState({
    required this.status,
    this.slot,
    this.seatsCount = 1,
    this.rentalCount = 0,
    this.idempotencyKey,
    this.booking,
    this.errorCode,
  });

  const BookingState.initial()
    : status = BookingFormStatus.initial,
      slot = null,
      seatsCount = 1,
      rentalCount = 0,
      idempotencyKey = null,
      booking = null,
      errorCode = null;

  final BookingFormStatus status;
  final SlotEntity? slot;
  final int seatsCount;
  final int rentalCount;
  final String? idempotencyKey;
  final BookingEntity? booking;
  final String? errorCode;

  int get estimatedTotal {
    final slotValue = slot;
    if (slotValue == null) {
      return 0;
    }
    return slotValue.priceAmount * seatsCount +
        slotValue.rentalPriceAmount * rentalCount;
  }

  int get maxSeats {
    final slotValue = slot;
    if (slotValue == null) {
      return 1;
    }
    return slotValue.freeSeats.clamp(1, 3);
  }

  int get maxRental {
    final slotValue = slot;
    if (slotValue == null) {
      return 0;
    }
    return slotValue.freeRentalKits.clamp(0, seatsCount);
  }

  BookingState copyWith({
    BookingFormStatus? status,
    SlotEntity? slot,
    int? seatsCount,
    int? rentalCount,
    String? idempotencyKey,
    BookingEntity? booking,
    String? errorCode,
  }) {
    return BookingState(
      status: status ?? this.status,
      slot: slot ?? this.slot,
      seatsCount: seatsCount ?? this.seatsCount,
      rentalCount: rentalCount ?? this.rentalCount,
      idempotencyKey: idempotencyKey ?? this.idempotencyKey,
      booking: booking ?? this.booking,
      errorCode: errorCode,
    );
  }

  @override
  List<Object?> get props => [
    status,
    slot,
    seatsCount,
    rentalCount,
    idempotencyKey,
    booking,
    errorCode,
  ];
}
