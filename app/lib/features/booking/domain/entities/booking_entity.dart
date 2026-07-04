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
  });

  final String id;
  final String slotId;
  final String clientId;
  final int seatsCount;
  final int rentalCount;
  final BookingStatus status;
  final int priceTotal;
  final DateTime createdAt;

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
  ];
}
