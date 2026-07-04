import 'package:equatable/equatable.dart';
import 'package:glina/features/slots/domain/enums/slot_enums.dart';

/// Default listing window per R-027 / FR-9 (7 days from today).
const defaultSlotsPeriodDays = 7;

class ProgramEntity extends Equatable {
  const ProgramEntity({
    required this.id,
    required this.name,
    required this.type,
    required this.capacityCap,
    required this.durationMin,
  });

  final String id;
  final String name;
  final ProgramType type;
  final int capacityCap;
  final int durationMin;

  @override
  List<Object?> get props => [id, name, type, capacityCap, durationMin];
}

class MasterEntity extends Equatable {
  const MasterEntity({required this.id, required this.name});

  final String id;
  final String name;

  @override
  List<Object?> get props => [id, name];
}

class SlotEntity extends Equatable {
  const SlotEntity({
    required this.id,
    required this.program,
    required this.master,
    required this.startAt,
    required this.totalSeats,
    required this.freeSeats,
    required this.freeRentalKits,
    required this.priceAmount,
    required this.rentalPriceAmount,
    required this.workshopAddress,
    required this.status,
  });

  final String id;
  final ProgramEntity program;
  final MasterEntity master;
  final DateTime startAt;
  final int totalSeats;
  final int freeSeats;
  final int freeRentalKits;
  final int priceAmount;
  final int rentalPriceAmount;
  final String workshopAddress;
  final SlotStatus status;

  bool get isBookable =>
      status == SlotStatus.scheduled && freeSeats > 0;

  @override
  List<Object?> get props => [
    id,
    program,
    master,
    startAt,
    totalSeats,
    freeSeats,
    freeRentalKits,
    priceAmount,
    rentalPriceAmount,
    workshopAddress,
    status,
  ];
}

class SlotsFilter extends Equatable {
  const SlotsFilter({
    this.dateFrom,
    this.dateTo,
    this.programTypes = const [],
    this.masterIds = const [],
    this.onlyAvailable = false,
  });

  factory SlotsFilter.defaultWeek({DateTime? now}) {
    final anchor = now ?? DateTime.now();
    final from = DateTime(anchor.year, anchor.month, anchor.day);
    final to = from.add(const Duration(days: defaultSlotsPeriodDays));
    return SlotsFilter(dateFrom: from, dateTo: to);
  }

  final DateTime? dateFrom;
  final DateTime? dateTo;
  final List<ProgramType> programTypes;
  final List<String> masterIds;
  final bool onlyAvailable;

  bool get hasActiveFilters =>
      programTypes.isNotEmpty ||
      masterIds.isNotEmpty ||
      onlyAvailable;

  SlotsFilter copyWith({
    DateTime? dateFrom,
    DateTime? dateTo,
    List<ProgramType>? programTypes,
    List<String>? masterIds,
    bool? onlyAvailable,
    bool clearProgramTypes = false,
    bool clearMasterIds = false,
  }) {
    return SlotsFilter(
      dateFrom: dateFrom ?? this.dateFrom,
      dateTo: dateTo ?? this.dateTo,
      programTypes: clearProgramTypes
          ? const []
          : (programTypes ?? this.programTypes),
      masterIds: clearMasterIds ? const [] : (masterIds ?? this.masterIds),
      onlyAvailable: onlyAvailable ?? this.onlyAvailable,
    );
  }

  SlotsFilter cleared() => SlotsFilter.defaultWeek();

  @override
  List<Object?> get props => [
    dateFrom,
    dateTo,
    programTypes,
    masterIds,
    onlyAvailable,
  ];
}
