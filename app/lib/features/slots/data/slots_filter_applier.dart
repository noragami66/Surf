import 'package:glina/features/slots/domain/entities/slot_entity.dart';

/// Applies [SlotsFilter] to a slot list (FR-38: OR within group, AND across).
List<SlotEntity> applySlotsFilter(
  List<SlotEntity> slots,
  SlotsFilter filter,
) {
  final filtered = slots.where((slot) => _matches(slot, filter)).toList()
    ..sort((a, b) => a.startAt.compareTo(b.startAt));
  return filtered;
}

bool _matches(SlotEntity slot, SlotsFilter filter) {
  if (!_inDateRange(slot.startAt, filter.dateFrom, filter.dateTo)) {
    return false;
  }
  if (filter.programTypes.isNotEmpty &&
      !filter.programTypes.contains(slot.program.type)) {
    return false;
  }
  if (filter.masterIds.isNotEmpty &&
      !filter.masterIds.contains(slot.master.id)) {
    return false;
  }
  if (filter.onlyAvailable && !slot.isBookable) {
    return false;
  }
  return true;
}

bool _inDateRange(DateTime startAt, DateTime? from, DateTime? to) {
  if (from != null) {
    final startOfFrom = DateTime(from.year, from.month, from.day);
    if (startAt.isBefore(startOfFrom)) {
      return false;
    }
  }
  if (to != null) {
    final endOfTo = DateTime(to.year, to.month, to.day, 23, 59, 59, 999);
    if (startAt.isAfter(endOfTo)) {
      return false;
    }
  }
  return true;
}
