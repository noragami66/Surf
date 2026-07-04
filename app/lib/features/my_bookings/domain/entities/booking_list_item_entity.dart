import 'package:equatable/equatable.dart';
import 'package:glina/features/booking/domain/entities/booking_entity.dart';
import 'package:glina/features/slots/domain/entities/slot_entity.dart';

/// Booking row enriched with slot data for the list screen.
class BookingListItemEntity extends Equatable {
  const BookingListItemEntity({required this.booking, required this.slot});

  final BookingEntity booking;
  final SlotEntity slot;

  @override
  List<Object?> get props => [booking, slot];
}
