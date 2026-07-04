import 'package:glina/features/slots/domain/entities/slot_entity.dart';
import 'package:glina/features/slots/domain/enums/slot_enums.dart';
import 'package:glina/features/slots/domain/repositories/i_slots_repository.dart';

class SlotsRepositoryMock implements ISlotsRepository {
  static final _mockSlots = [
    SlotEntity(
      id: 'slot-1',
      program: const ProgramEntity(
        id: 'prog-1',
        name: 'Ручная лепка: чашка',
        type: ProgramType.handbuilding,
        capacityCap: 8,
        durationMin: 120,
      ),
      master: const MasterEntity(id: 'master-1', name: 'Анна К.'),
      startAt: DateTime.now().add(const Duration(days: 1, hours: 18)),
      totalSeats: 8,
      freeSeats: 3,
      freeRentalKits: 5,
      priceAmount: 3200,
      rentalPriceAmount: 400,
      workshopAddress: 'ул. Гончарная, 12',
      status: SlotStatus.scheduled,
    ),
    SlotEntity(
      id: 'slot-2',
      program: const ProgramEntity(
        id: 'prog-2',
        name: 'Гончарный круг: ваза',
        type: ProgramType.wheel,
        capacityCap: 6,
        durationMin: 150,
      ),
      master: const MasterEntity(id: 'master-2', name: 'Михаил Р.'),
      startAt: DateTime.now().add(const Duration(days: 2, hours: 14)),
      totalSeats: 6,
      freeSeats: 1,
      freeRentalKits: 2,
      priceAmount: 4500,
      rentalPriceAmount: 500,
      workshopAddress: 'ул. Гончарная, 12',
      status: SlotStatus.scheduled,
    ),
    SlotEntity(
      id: 'slot-3',
      program: const ProgramEntity(
        id: 'prog-3',
        name: 'Семейное занятие',
        type: ProgramType.handbuilding,
        capacityCap: 10,
        durationMin: 90,
      ),
      master: const MasterEntity(id: 'master-1', name: 'Анна К.'),
      startAt: DateTime.now().add(const Duration(days: 4, hours: 11)),
      totalSeats: 10,
      freeSeats: 7,
      freeRentalKits: 8,
      priceAmount: 2800,
      rentalPriceAmount: 350,
      workshopAddress: 'ул. Гончарная, 12',
      status: SlotStatus.scheduled,
    ),
  ];

  @override
  Future<SlotEntity> getSlot(String slotId) async {
    final items = await listSlots(const SlotsFilter());
    return items.firstWhere((slot) => slot.id == slotId);
  }

  @override
  Future<List<SlotEntity>> listSlots(SlotsFilter filter) async {
    await Future<void>.delayed(const Duration(milliseconds: 450));
    return List.unmodifiable(_mockSlots);
  }
}
