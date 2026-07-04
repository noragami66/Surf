import 'package:glina/features/slots/domain/entities/slot_entity.dart';
import 'package:glina/features/slots/domain/repositories/i_slots_repository.dart';

class SlotsRepositoryMock implements ISlotsRepository {
  @override
  Future<SlotEntity> getSlot(String slotId) async {
    final items = await listSlots(const SlotsFilter());
    return items.firstWhere((slot) => slot.id == slotId);
  }

  @override
  Future<List<SlotEntity>> listSlots(SlotsFilter filter) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return const [];
  }
}
