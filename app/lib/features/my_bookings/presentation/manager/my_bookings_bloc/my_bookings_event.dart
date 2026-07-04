part of 'my_bookings_bloc.dart';

sealed class MyBookingsEvent extends Equatable {
  const MyBookingsEvent();

  @override
  List<Object?> get props => [];
}

final class LoadMyBookingsEvent extends MyBookingsEvent {
  const LoadMyBookingsEvent(this.clientId);

  final String clientId;

  @override
  List<Object?> get props => [clientId];
}

final class RefreshMyBookingsEvent extends MyBookingsEvent {
  const RefreshMyBookingsEvent(this.clientId);

  final String clientId;

  @override
  List<Object?> get props => [clientId];
}

final class ResetMyBookingsEvent extends MyBookingsEvent {
  const ResetMyBookingsEvent();
}
