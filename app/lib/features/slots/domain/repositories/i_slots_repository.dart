import 'package:glina/features/slots/domain/entities/slot_entity.dart';

abstract interface class ISlotsRepository {
  Future<List<SlotEntity>> listSlots(SlotsFilter filter);

  Future<List<MasterEntity>> listMasters();

  Future<SlotEntity> getSlot(String slotId);
}
