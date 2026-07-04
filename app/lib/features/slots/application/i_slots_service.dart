import 'package:glina/features/slots/domain/entities/slot_entity.dart';

abstract interface class ISlotsService {
  Future<List<SlotEntity>> listSlots(SlotsFilter filter);

  Future<SlotEntity> getSlot(String slotId);
}
