import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glina/core/exception/app_exception.dart';
import 'package:glina/features/slots/application/i_slots_service.dart';
import 'package:glina/features/slots/domain/entities/slot_entity.dart';
import 'package:glina/features/slots/domain/enums/slot_enums.dart';
import 'package:glina/features/slots/presentation/manager/slot_detail_bloc/slot_detail_bloc.dart';
import 'package:mocktail/mocktail.dart';

class _MockSlotsService extends Mock implements ISlotsService {}

void main() {
  const slotId = 'slot-1';

  final slot = SlotEntity(
    id: slotId,
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

  setUp(() => service = _MockSlotsService());

  blocTest<SlotDetailBloc, SlotDetailState>(
    'emits loaded on success',
    setUp: () =>
        when(() => service.getSlot(slotId)).thenAnswer((_) async => slot),
    build: () => SlotDetailBloc(service: service, slotId: slotId),
    act: (bloc) => bloc.add(const LoadSlotDetailEvent()),
    expect: () => [
      isA<SlotDetailState>().having(
        (s) => s.status,
        'status',
        SlotDetailStatus.loading,
      ),
      isA<SlotDetailState>()
          .having((s) => s.status, 'status', SlotDetailStatus.loaded)
          .having((s) => s.canBook, 'canBook', isTrue),
    ],
  );

  blocTest<SlotDetailBloc, SlotDetailState>(
    'emits notFound when slot is missing',
    setUp: () => when(
      () => service.getSlot(slotId),
    ).thenThrow(SlotNotFoundException(slotId)),
    build: () => SlotDetailBloc(service: service, slotId: slotId),
    act: (bloc) => bloc.add(const LoadSlotDetailEvent()),
    expect: () => [
      isA<SlotDetailState>().having(
        (s) => s.status,
        'status',
        SlotDetailStatus.loading,
      ),
      isA<SlotDetailState>().having(
        (s) => s.status,
        'status',
        SlotDetailStatus.notFound,
      ),
    ],
  );
}
