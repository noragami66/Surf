import 'package:glina/features/booking/domain/entities/booking_entity.dart';
import 'package:glina/features/slots/domain/entities/slot_entity.dart';
import 'package:glina/features/slots/domain/enums/slot_enums.dart';

/// Shared in-memory store for slot and booking mocks (stage 5+).
class MockSlotStore {
  MockSlotStore._();

  static final MockSlotStore instance = MockSlotStore._();

  static const workshopAddress = 'ул. Гончарная, 12';

  static const masters = [
    MasterEntity(id: 'master-1', name: 'Анна К.'),
    MasterEntity(id: 'master-2', name: 'Михаил Р.'),
    MasterEntity(id: 'master-3', name: 'Елена В.'),
    MasterEntity(id: 'master-4', name: 'Дмитрий С.'),
  ];

  static const _handCup = ProgramEntity(
    id: 'prog-hand-1',
    name: 'Лепка для новичков: чашка',
    type: ProgramType.handbuilding,
    capacityCap: 8,
    durationMin: 120,
  );

  static const _handFamily = ProgramEntity(
    id: 'prog-hand-2',
    name: 'Семейное занятие',
    type: ProgramType.handbuilding,
    capacityCap: 10,
    durationMin: 90,
  );

  static const _wheelVase = ProgramEntity(
    id: 'prog-wheel-1',
    name: 'Гончарный круг: ваза',
    type: ProgramType.wheel,
    capacityCap: 6,
    durationMin: 150,
  );

  static const _wheelPlate = ProgramEntity(
    id: 'prog-wheel-2',
    name: 'Гончарный круг: тарелка',
    type: ProgramType.wheel,
    capacityCap: 6,
    durationMin: 120,
  );

  final List<SlotEntity> slots = _seedSlots();
  final List<BookingEntity> bookings = [];
  final Map<String, BookingEntity> idempotencyKeys = {};

  static List<SlotEntity> _seedSlots() {
    final now = DateTime.now();
    final day = DateTime(now.year, now.month, now.day);

    SlotEntity slot({
      required String id,
      required ProgramEntity program,
      required MasterEntity master,
      required int dayOffset,
      required int hour,
      required int totalSeats,
      required int freeSeats,
      required int price,
      SlotStatus status = SlotStatus.scheduled,
    }) {
      return SlotEntity(
        id: id,
        program: program,
        master: master,
        startAt: day.add(Duration(days: dayOffset, hours: hour)),
        totalSeats: totalSeats,
        freeSeats: freeSeats,
        freeRentalKits: (freeSeats * 0.8).floor().clamp(0, 8),
        priceAmount: price,
        rentalPriceAmount: 400,
        workshopAddress: workshopAddress,
        status: status,
      );
    }

    return [
      slot(
        id: 'slot-1',
        program: _handCup,
        master: masters[0],
        dayOffset: 0,
        hour: 18,
        totalSeats: 8,
        freeSeats: 3,
        price: 3200,
      ),
      slot(
        id: 'slot-2',
        program: _wheelVase,
        master: masters[1],
        dayOffset: 1,
        hour: 14,
        totalSeats: 6,
        freeSeats: 1,
        price: 4500,
      ),
      slot(
        id: 'slot-3',
        program: _handFamily,
        master: masters[0],
        dayOffset: 1,
        hour: 11,
        totalSeats: 10,
        freeSeats: 7,
        price: 2800,
      ),
      slot(
        id: 'slot-4',
        program: _wheelPlate,
        master: masters[2],
        dayOffset: 2,
        hour: 16,
        totalSeats: 6,
        freeSeats: 0,
        price: 4200,
      ),
      slot(
        id: 'slot-5',
        program: _handCup,
        master: masters[3],
        dayOffset: 2,
        hour: 10,
        totalSeats: 8,
        freeSeats: 4,
        price: 3200,
      ),
      slot(
        id: 'slot-6',
        program: _wheelVase,
        master: masters[1],
        dayOffset: 3,
        hour: 12,
        totalSeats: 6,
        freeSeats: 2,
        price: 4500,
      ),
      slot(
        id: 'slot-7',
        program: _handFamily,
        master: masters[2],
        dayOffset: 3,
        hour: 18,
        totalSeats: 10,
        freeSeats: 0,
        price: 2800,
        status: SlotStatus.cancelled,
      ),
      slot(
        id: 'slot-8',
        program: _handCup,
        master: masters[0],
        dayOffset: 4,
        hour: 15,
        totalSeats: 8,
        freeSeats: 5,
        price: 3200,
      ),
      slot(
        id: 'slot-9',
        program: _wheelPlate,
        master: masters[3],
        dayOffset: 4,
        hour: 11,
        totalSeats: 6,
        freeSeats: 3,
        price: 4200,
      ),
      slot(
        id: 'slot-10',
        program: _wheelVase,
        master: masters[2],
        dayOffset: 5,
        hour: 14,
        totalSeats: 6,
        freeSeats: 1,
        price: 4500,
      ),
      slot(
        id: 'slot-11',
        program: _handCup,
        master: masters[1],
        dayOffset: 5,
        hour: 18,
        totalSeats: 8,
        freeSeats: 6,
        price: 3200,
      ),
      slot(
        id: 'slot-12',
        program: _handFamily,
        master: masters[3],
        dayOffset: 6,
        hour: 12,
        totalSeats: 10,
        freeSeats: 8,
        price: 2800,
      ),
      slot(
        id: 'slot-13',
        program: _wheelPlate,
        master: masters[0],
        dayOffset: 6,
        hour: 17,
        totalSeats: 6,
        freeSeats: 2,
        price: 4200,
      ),
      slot(
        id: 'slot-14',
        program: _wheelVase,
        master: masters[1],
        dayOffset: 6,
        hour: 10,
        totalSeats: 6,
        freeSeats: 0,
        price: 4500,
      ),
      slot(
        id: 'slot-15',
        program: _handCup,
        master: masters[2],
        dayOffset: 10,
        hour: 14,
        totalSeats: 8,
        freeSeats: 8,
        price: 3200,
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
