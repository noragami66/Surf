import 'package:flutter_test/flutter_test.dart';
import 'package:glina/features/slots/data/mock_slot_store.dart';
import 'package:glina/features/slots/data/repositories/slots_repository_mock.dart';
import 'package:glina/features/slots/domain/entities/slot_entity.dart';
import 'package:glina/features/slots/domain/enums/slot_enums.dart';

void main() {
  late MockSlotStore store;
  late SlotsRepositoryMock repository;

  setUp(() {
    store = MockSlotStore.instance..reset();
    repository = SlotsRepositoryMock(store: store);
  });

  test(
    'listSlots with default week returns 14 slots (excludes day 10)',
    () async {
      final filter = SlotsFilter.defaultWeek();
      final slots = await repository.listSlots(filter);

      expect(slots, hasLength(14));
      expect(slots.any((s) => s.id == 'slot-15'), isFalse);
    },
  );

  test('listMasters returns four masters', () async {
    final masters = await repository.listMasters();
    expect(masters, hasLength(4));
  });

  test('onlyAvailable filter removes full slots', () async {
    final filter = SlotsFilter.defaultWeek().copyWith(onlyAvailable: true);
    final slots = await repository.listSlots(filter);

    expect(slots.every((s) => s.freeSeats > 0), isTrue);
    expect(slots.every((s) => s.status == SlotStatus.scheduled), isTrue);
  });
}
