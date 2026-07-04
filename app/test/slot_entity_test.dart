import 'package:flutter_test/flutter_test.dart';
import 'package:glina/features/slots/domain/entities/slot_entity.dart';
import 'package:glina/features/slots/domain/enums/slot_enums.dart';

void main() {
  test('SlotEntity supports value equality', () {
    const program = ProgramEntity(
      id: 'p1',
      name: 'Handbuilding',
      type: ProgramType.handbuilding,
      capacityCap: 6,
      durationMin: 120,
    );
    const master = MasterEntity(id: 'm1', name: 'Anna');
    final slot = SlotEntity(
      id: 's1',
      program: program,
      master: master,
      startAt: DateTime.utc(2026, 7, 10, 14),
      totalSeats: 6,
      freeSeats: 2,
      freeRentalKits: 3,
      priceAmount: 250000,
      rentalPriceAmount: 50000,
      workshopAddress: 'Address',
      status: SlotStatus.scheduled,
    );

    expect(slot, equals(slot));
  });
}
