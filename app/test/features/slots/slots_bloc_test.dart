import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glina/features/slots/application/i_slots_service.dart';
import 'package:glina/features/slots/domain/entities/slot_entity.dart';
import 'package:glina/features/slots/domain/enums/slot_enums.dart';
import 'package:glina/features/slots/presentation/manager/slots_bloc/slots_bloc.dart';
import 'package:mocktail/mocktail.dart';

class _MockSlotsService extends Mock implements ISlotsService {}

void main() {
  setUpAll(() {
    registerFallbackValue(const SlotsFilter());
  });

  final slot = SlotEntity(
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
  );

  late ISlotsService service;

  setUp(() {
    service = _MockSlotsService();
    when(() => service.listSlots(any())).thenAnswer((_) async => [slot]);
  });

  blocTest<SlotsBloc, SlotsState>(
    'emits loaded with slots on LoadSlotsEvent',
    build: () => SlotsBloc(service: service),
    act: (bloc) => bloc.add(const LoadSlotsEvent()),
    expect: () => [
      isA<SlotsState>().having((s) => s.status, 'status', SlotsStatus.loading),
      isA<SlotsState>()
          .having((s) => s.status, 'status', SlotsStatus.loaded)
          .having((s) => s.slots, 'slots', hasLength(1)),
    ],
  );

  blocTest<SlotsBloc, SlotsState>(
    'emits empty when service returns no slots',
    setUp: () =>
        when(() => service.listSlots(any())).thenAnswer((_) async => []),
    build: () => SlotsBloc(service: service),
    act: (bloc) => bloc.add(const LoadSlotsEvent()),
    expect: () => [
      isA<SlotsState>().having((s) => s.status, 'status', SlotsStatus.loading),
      isA<SlotsState>().having((s) => s.status, 'status', SlotsStatus.empty),
    ],
  );
}
