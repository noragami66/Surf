import 'package:glina/features/slots/application/i_slots_service.dart';
import 'package:glina/features/slots/domain/entities/slot_entity.dart';
import 'package:glina/features/slots/domain/repositories/i_slots_repository.dart';

class SlotsServiceImpl implements ISlotsService {
  SlotsServiceImpl({required ISlotsRepository repository})
    : _repository = repository;

  final ISlotsRepository _repository;

  @override
  Future<SlotEntity> getSlot(String slotId) => _repository.getSlot(slotId);

  @override
  Future<List<SlotEntity>> listSlots(SlotsFilter filter) =>
      _repository.listSlots(filter);
}
