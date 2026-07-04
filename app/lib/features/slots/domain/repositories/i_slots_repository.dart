import 'package:glina/features/slots/domain/entities/slot_entity.dart';

abstract interface class ISlotsRepository {
  Future<List<SlotEntity>> listSlots(SlotsFilter filter);

  Future<SlotEntity> getSlot(String slotId);
}
