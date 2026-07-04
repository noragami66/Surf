import 'package:flutter_test/flutter_test.dart';
import 'package:glina/features/slots/data/slots_filter_applier.dart';
import 'package:glina/features/slots/domain/entities/slot_entity.dart';
import 'package:glina/features/slots/domain/enums/slot_enums.dart';

void main() {
  final base = DateTime(2026, 7, 4, 12);

  SlotEntity slot({
    required String id,
    required ProgramType type,
    required String masterId,
    required int dayOffset,
    required int freeSeats,
    SlotStatus status = SlotStatus.scheduled,
  }) {
    return SlotEntity(
      id: id,
      program: ProgramEntity(
        id: 'p-$type',
        name: 'Program',
        type: type,
        capacityCap: 8,
        durationMin: 120,
      ),
      master: MasterEntity(id: masterId, name: masterId),
      startAt: base.add(Duration(days: dayOffset)),
      totalSeats: 8,
      freeSeats: freeSeats,
      freeRentalKits: 4,
      priceAmount: 3000,
      rentalPriceAmount: 400,
      workshopAddress: 'Addr',
      status: status,
    );
  }

  group('applySlotsFilter', () {
    final slots = [
      slot(
        id: '1',
        type: ProgramType.handbuilding,
        masterId: 'm1',
        dayOffset: 1,
        freeSeats: 2,
      ),
      slot(
        id: '2',
        type: ProgramType.wheel,
        masterId: 'm2',
        dayOffset: 3,
        freeSeats: 0,
      ),
      slot(
        id: '3',
        type: ProgramType.handbuilding,
        masterId: 'm2',
        dayOffset: 8,
        freeSeats: 5,
      ),
    ];

    test('default week excludes slots beyond 7 days', () {
      final filter = SlotsFilter.defaultWeek(now: base);
      final result = applySlotsFilter(slots, filter);

      expect(result.map((s) => s.id), ['1', '2']);
    });

    test('program type filter uses OR within group', () {
      final filter = SlotsFilter.defaultWeek(now: base).copyWith(
        programTypes: [ProgramType.handbuilding],
      );
      final result = applySlotsFilter(slots, filter);

      expect(result, hasLength(1));
      expect(result.first.id, '1');
    });

    test('onlyAvailable hides full and cancelled slots', () {
      final filter = SlotsFilter.defaultWeek(now: base).copyWith(
        onlyAvailable: true,
      );
      final result = applySlotsFilter(slots, filter);

      expect(result.map((s) => s.id), ['1']);
    });

    test('master filter matches selected masters', () {
      final filter = SlotsFilter.defaultWeek(now: base).copyWith(
        masterIds: ['m2'],
      );
      final result = applySlotsFilter(slots, filter);

      expect(result.map((s) => s.id), ['2']);
    });
  });
}
