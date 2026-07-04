part of 'booking_detail_bloc.dart';

enum BookingDetailStatus {
  initial,
  loading,
  loaded,
  cancelling,
  cancelled,
  failure,
}

class BookingDetailState extends Equatable {
  const BookingDetailState({required this.status, this.item, this.errorCode});

  const BookingDetailState.initial()
    : status = BookingDetailStatus.initial,
      item = null,
      errorCode = null;

  final BookingDetailStatus status;
  final BookingListItemEntity? item;
  final String? errorCode;

  BookingDetailState copyWith({
    BookingDetailStatus? status,
    BookingListItemEntity? item,
    String? errorCode,
  }) {
    return BookingDetailState(
      status: status ?? this.status,
      item: item ?? this.item,
      errorCode: errorCode,
    );
  }

  @override
  List<Object?> get props => [status, item, errorCode];
}
