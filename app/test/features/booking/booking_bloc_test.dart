import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glina/core/exception/app_exception.dart';
import 'package:glina/features/booking/application/i_booking_service.dart';
import 'package:glina/features/booking/domain/entities/booking_entity.dart';
import 'package:glina/features/booking/domain/enums/booking_enums.dart'
    as domain;
import 'package:glina/features/booking/presentation/manager/booking_bloc/booking_bloc.dart';
import 'package:glina/features/slots/application/i_slots_service.dart';
import 'package:glina/features/slots/domain/entities/slot_entity.dart';
import 'package:glina/features/slots/domain/enums/slot_enums.dart';
import 'package:mocktail/mocktail.dart';

class _MockBookingService extends Mock implements IBookingService {}

class _MockSlotsService extends Mock implements ISlotsService {}

void main() {
  const slotId = 'slot-1';
  const clientId = 'client-1';

  final slot = SlotEntity(
    id: slotId,
    program: const ProgramEntity(
      id: 'prog-1',
      name: 'Test',
      type: ProgramType.handbuilding,
      capacityCap: 8,
      durationMin: 120,
    ),
    master: const MasterEntity(id: 'm1', name: 'Anna'),
    startAt: DateTime.now().add(const Duration(days: 1)),
    totalSeats: 8,
    freeSeats: 3,
    freeRentalKits: 2,
    priceAmount: 1000,
    rentalPriceAmount: 200,
    workshopAddress: 'Address',
    status: SlotStatus.scheduled,
  );

  late IBookingService bookingService;
  late ISlotsService slotsService;

  setUp(() {
    bookingService = _MockBookingService();
    slotsService = _MockSlotsService();
  });

  BookingBloc buildBloc() => BookingBloc(
    bookingService: bookingService,
    slotsService: slotsService,
    slotId: slotId,
    clientId: clientId,
  );

  group('LoadBookingSlotEvent', () {
    blocTest<BookingBloc, BookingState>(
      'emits editing with slot on success',
      setUp: () => when(
        () => slotsService.getSlot(slotId),
      ).thenAnswer((_) async => slot),
      build: buildBloc,
      act: (bloc) => bloc.add(const LoadBookingSlotEvent()),
      expect: () => [
        isA<BookingState>().having(
          (s) => s.status,
          'status',
          BookingFormStatus.loading,
        ),
        isA<BookingState>()
            .having((s) => s.status, 'status', BookingFormStatus.editing)
            .having((s) => s.slot?.id, 'slotId', slotId),
      ],
    );
  });

  group('SubmitBookingEvent', () {
    blocTest<BookingBloc, BookingState>(
      'emits success when booking is created',
      setUp: () {
        when(() => slotsService.getSlot(slotId)).thenAnswer((_) async => slot);
        when(
          () => bookingService.createBooking(
            clientId: clientId,
            slotId: slotId,
            seatsCount: 1,
            rentalCount: 0,
            idempotencyKey: any(named: 'idempotencyKey'),
          ),
        ).thenAnswer(
          (_) async => BookingEntity(
            id: 'b1',
            slotId: slotId,
            clientId: clientId,
            seatsCount: 1,
            rentalCount: 0,
            status: domain.BookingStatus.active,
            priceTotal: 1000,
            createdAt: DateTime.now(),
          ),
        );
      },
      build: buildBloc,
      act: (bloc) async {
        bloc
          ..add(const LoadBookingSlotEvent())
          ..add(const SubmitBookingEvent());
        await Future<void>.delayed(Duration.zero);
      },
      expect: () => [
        isA<BookingState>(),
        isA<BookingState>(),
        isA<BookingState>().having(
          (s) => s.status,
          'status',
          BookingFormStatus.submitting,
        ),
        isA<BookingState>().having(
          (s) => s.status,
          'status',
          BookingFormStatus.success,
        ),
      ],
    );

    blocTest<BookingBloc, BookingState>(
      'emits slot_full error code on SlotFullException',
      setUp: () {
        when(() => slotsService.getSlot(slotId)).thenAnswer((_) async => slot);
        when(
          () => bookingService.createBooking(
            clientId: any(named: 'clientId'),
            slotId: any(named: 'slotId'),
            seatsCount: any(named: 'seatsCount'),
            rentalCount: any(named: 'rentalCount'),
            idempotencyKey: any(named: 'idempotencyKey'),
          ),
        ).thenThrow(
          const SlotFullException(availableSeats: 0, availableRentalKits: 0),
        );
      },
      build: buildBloc,
      seed: () => BookingState(status: BookingFormStatus.editing, slot: slot),
      act: (bloc) => bloc.add(const SubmitBookingEvent()),
      expect: () => [
        isA<BookingState>().having(
          (s) => s.status,
          'status',
          BookingFormStatus.submitting,
        ),
        isA<BookingState>()
            .having((s) => s.status, 'status', BookingFormStatus.editing)
            .having((s) => s.errorCode, 'errorCode', 'slot_full'),
      ],
    );
  });
}
