part of 'booking_bloc.dart';

sealed class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object?> get props => [];
}

final class LoadBookingSlotEvent extends BookingEvent {
  const LoadBookingSlotEvent();
}

final class BookingSeatsChanged extends BookingEvent {
  const BookingSeatsChanged(this.seatsCount);

  final int seatsCount;

  @override
  List<Object?> get props => [seatsCount];
}

final class BookingRentalChanged extends BookingEvent {
  const BookingRentalChanged(this.rentalCount);

  final int rentalCount;

  @override
  List<Object?> get props => [rentalCount];
}

final class SubmitBookingEvent extends BookingEvent {
  const SubmitBookingEvent();
}
