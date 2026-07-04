import 'package:glina/core/exception/app_exception.dart';
import 'package:glina/features/slots/data/mock_slot_store.dart';
import 'package:glina/features/slots/data/slots_filter_applier.dart';
import 'package:glina/features/slots/domain/entities/slot_entity.dart';
import 'package:glina/features/slots/domain/repositories/i_slots_repository.dart';

class SlotsRepositoryMock implements ISlotsRepository {
  SlotsRepositoryMock({MockSlotStore? store})
    : _store = store ?? MockSlotStore.instance;

  final MockSlotStore _store;
  static const _latency = Duration(milliseconds: 450);

  @override
  Future<SlotEntity> getSlot(String slotId) async {
    await Future<void>.delayed(_latency);
    final slot = _store.findSlot(slotId);
    if (slot == null) {
      throw SlotNotFoundException(slotId);
    }
    return slot;
  }

  @override
  Future<List<MasterEntity>> listMasters() async {
    await Future<void>.delayed(_latency);
    return List.unmodifiable(MockSlotStore.masters);
  }

  @override
  Future<List<SlotEntity>> listSlots(SlotsFilter filter) async {
    await Future<void>.delayed(_latency);
    return applySlotsFilter(_store.slots, filter);
  }
}
