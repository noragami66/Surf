import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glina/features/booking/domain/entities/booking_entity.dart';
import 'package:glina/features/booking/domain/enums/booking_enums.dart';
import 'package:glina/features/my_bookings/application/i_my_bookings_service.dart';
import 'package:glina/features/my_bookings/domain/entities/booking_list_item_entity.dart';
import 'package:glina/features/my_bookings/presentation/manager/my_bookings_bloc/my_bookings_bloc.dart';
import 'package:glina/features/slots/domain/entities/slot_entity.dart';
import 'package:glina/features/slots/domain/enums/slot_enums.dart';
import 'package:mocktail/mocktail.dart';

class _MockMyBookingsService extends Mock implements IMyBookingsService {}

void main() {
  const clientId = 'client-1';

  final item = BookingListItemEntity(
    booking: BookingEntity(
      id: 'b1',
      slotId: 'slot-1',
      clientId: clientId,
      seatsCount: 1,
      rentalCount: 0,
      status: BookingStatus.active,
      priceTotal: 1000,
      createdAt: DateTime.now(),
    ),
    slot: SlotEntity(
      id: 'slot-1',
      program: const ProgramEntity(
        id: 'p1',
        name: 'Test',
        type: ProgramType.handbuilding,
        capacityCap: 6,
        durationMin: 120,
      ),
      master: const MasterEntity(id: 'm1', name: 'Anna'),
      startAt: DateTime.now().add(const Duration(days: 1)),
      totalSeats: 6,
      freeSeats: 2,
      freeRentalKits: 3,
      priceAmount: 1000,
      rentalPriceAmount: 100,
      workshopAddress: 'Addr',
      status: SlotStatus.scheduled,
    ),
  );

  late IMyBookingsService service;

  setUp(() => service = _MockMyBookingsService());

  blocTest<MyBookingsBloc, MyBookingsState>(
    'emits loaded on LoadMyBookingsEvent',
    setUp: () => when(
      () => service.listBookings(clientId),
    ).thenAnswer((_) async => [item]),
    build: () => MyBookingsBloc(service: service),
    act: (bloc) => bloc.add(const LoadMyBookingsEvent(clientId)),
    expect: () => [
      isA<MyBookingsState>().having(
        (s) => s.status,
        'status',
        MyBookingsStatus.loading,
      ),
      isA<MyBookingsState>()
          .having((s) => s.status, 'status', MyBookingsStatus.loaded)
          .having((s) => s.items, 'items', hasLength(1)),
    ],
  );

  blocTest<MyBookingsBloc, MyBookingsState>(
    'ResetMyBookingsEvent clears state',
    build: () => MyBookingsBloc(service: service),
    seed: () => MyBookingsState(status: MyBookingsStatus.loaded, items: [item]),
    act: (bloc) => bloc.add(const ResetMyBookingsEvent()),
    expect: () => [
      isA<MyBookingsState>().having(
        (s) => s.status,
        'status',
        MyBookingsStatus.initial,
      ),
    ],
  );
}
