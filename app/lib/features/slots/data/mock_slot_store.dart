import 'package:glina/features/booking/domain/entities/booking_entity.dart';
import 'package:glina/features/slots/domain/entities/slot_entity.dart';
import 'package:glina/features/slots/domain/enums/slot_enums.dart';

/// Shared in-memory store for slot and booking mocks (stage 5+).
class MockSlotStore {
  MockSlotStore._();

  static final MockSlotStore instance = MockSlotStore._();

  final List<SlotEntity> slots = _seedSlots();
  final List<BookingEntity> bookings = [];
  final Map<String, BookingEntity> idempotencyKeys = {};

  static List<SlotEntity> _seedSlots() {
    return [
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
  }

  SlotEntity? findSlot(String slotId) {
    for (final slot in slots) {
      if (slot.id == slotId) {
        return slot;
      }
    }
    return null;
  }

  void updateSlot(int index, SlotEntity slot) {
    slots[index] = slot;
  }

  int slotIndex(String slotId) => slots.indexWhere((s) => s.id == slotId);

  /// Clears bookings and restores seed slots (for tests).
  void reset() {
    bookings.clear();
    idempotencyKeys.clear();
    slots
      ..clear()
      ..addAll(_seedSlots());
  }
}
