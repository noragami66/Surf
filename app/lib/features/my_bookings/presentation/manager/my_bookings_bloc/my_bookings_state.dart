part of 'my_bookings_bloc.dart';

enum MyBookingsStatus { initial, loading, loaded, empty, failure }

class MyBookingsState extends Equatable {
  const MyBookingsState({
    required this.status,
    this.items = const [],
    this.errorMessage,
  });

  const MyBookingsState.initial() : this(status: MyBookingsStatus.initial);

  final MyBookingsStatus status;
  final List<BookingListItemEntity> items;
  final String? errorMessage;

  MyBookingsState copyWith({
    MyBookingsStatus? status,
    List<BookingListItemEntity>? items,
    String? errorMessage,
  }) {
    return MyBookingsState(
      status: status ?? this.status,
      items: items ?? this.items,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, items, errorMessage];
}
