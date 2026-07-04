import 'package:equatable/equatable.dart';
import 'package:glina/features/booking/domain/enums/booking_enums.dart';

class BookingEntity extends Equatable {
  const BookingEntity({
    required this.id,
    required this.slotId,
    required this.clientId,
    required this.seatsCount,
    required this.rentalCount,
    required this.status,
    required this.priceTotal,
    required this.createdAt,
    this.cancelledAt,
    this.workshopCancelReason,
  });

  final String id;
  final String slotId;
  final String clientId;
  final int seatsCount;
  final int rentalCount;
  final BookingStatus status;
  final int priceTotal;
  final DateTime createdAt;
  final DateTime? cancelledAt;
  final String? workshopCancelReason;

  bool get isCancellable => status == BookingStatus.active;

  BookingEntity copyWith({
    String? id,
    String? slotId,
    String? clientId,
    int? seatsCount,
    int? rentalCount,
    BookingStatus? status,
    int? priceTotal,
    DateTime? createdAt,
    DateTime? cancelledAt,
    String? workshopCancelReason,
  }) {
    return BookingEntity(
      id: id ?? this.id,
      slotId: slotId ?? this.slotId,
      clientId: clientId ?? this.clientId,
      seatsCount: seatsCount ?? this.seatsCount,
      rentalCount: rentalCount ?? this.rentalCount,
      status: status ?? this.status,
      priceTotal: priceTotal ?? this.priceTotal,
      createdAt: createdAt ?? this.createdAt,
      cancelledAt: cancelledAt ?? this.cancelledAt,
      workshopCancelReason: workshopCancelReason ?? this.workshopCancelReason,
    );
  }

  @override
  List<Object?> get props => [
    id,
    slotId,
    clientId,
    seatsCount,
    rentalCount,
    status,
    priceTotal,
    createdAt,
    cancelledAt,
    workshopCancelReason,
  ];
}
