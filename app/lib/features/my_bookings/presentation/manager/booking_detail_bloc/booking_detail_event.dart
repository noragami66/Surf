part of 'booking_detail_bloc.dart';

sealed class BookingDetailEvent extends Equatable {
  const BookingDetailEvent();

  @override
  List<Object?> get props => [];
}

final class LoadBookingDetailEvent extends BookingDetailEvent {
  const LoadBookingDetailEvent();
}

final class CancelBookingEvent extends BookingDetailEvent {
  const CancelBookingEvent();
}
