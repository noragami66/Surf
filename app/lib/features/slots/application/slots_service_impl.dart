import 'package:glina/features/auth/application/i_auth_service.dart';
import 'package:glina/features/slots/application/i_slots_service.dart';
import 'package:glina/features/slots/domain/entities/slot_entity.dart';
import 'package:glina/features/slots/domain/repositories/i_slots_repository.dart';

class SlotsServiceImpl implements ISlotsService {
  SlotsServiceImpl({
    required ISlotsRepository repository,
    required IAuthService authService,
  }) : _repository = repository,
       _authService = authService;

  final ISlotsRepository _repository;
  final IAuthService _authService;

  @override
  Future<SlotEntity> getSlot(String slotId) async {
    await _authService.ensureValidSession();
    return _repository.getSlot(slotId);
  }

  @override
  Future<List<SlotEntity>> listSlots(SlotsFilter filter) async {
    await _authService.ensureValidSession();
    return _repository.listSlots(filter);
  }

  @override
  Future<List<MasterEntity>> listMasters() async {
    await _authService.ensureValidSession();
    return _repository.listMasters();
  }
}
