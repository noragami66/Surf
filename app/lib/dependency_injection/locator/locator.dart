import 'package:get_it/get_it.dart';
import 'package:glina/features/auth/application/auth_service_impl.dart';
import 'package:glina/features/auth/application/i_auth_service.dart';
import 'package:glina/features/auth/data/repositories/auth_repository_mock.dart';
import 'package:glina/features/auth/data/secure_token_storage.dart';
import 'package:glina/features/auth/data/token_storage.dart';
import 'package:glina/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:glina/features/auth/presentation/manager/auth_bloc/auth_bloc.dart';
import 'package:glina/features/booking/application/booking_service_impl.dart';
import 'package:glina/features/booking/application/i_booking_service.dart';
import 'package:glina/features/booking/data/repositories/booking_repository_mock.dart';
import 'package:glina/features/booking/domain/repositories/i_booking_repository.dart';
import 'package:glina/features/booking/presentation/manager/booking_bloc/booking_bloc.dart';
import 'package:glina/features/my_bookings/application/i_my_bookings_service.dart';
import 'package:glina/features/my_bookings/application/my_bookings_service_impl.dart';
import 'package:glina/features/my_bookings/presentation/manager/my_bookings_bloc/my_bookings_bloc.dart';
import 'package:glina/features/slots/application/i_slots_service.dart';
import 'package:glina/features/slots/application/slots_service_impl.dart';
import 'package:glina/features/slots/data/repositories/slots_repository_mock.dart';
import 'package:glina/features/slots/domain/repositories/i_slots_repository.dart';
import 'package:glina/features/slots/presentation/manager/slot_detail_bloc/slot_detail_bloc.dart';
import 'package:glina/features/slots/presentation/manager/slots_bloc/slots_bloc.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator
    ..registerLazySingleton<ITokenStorage>(SecureTokenStorage.new)
    ..registerLazySingleton<IAuthRepository>(AuthRepositoryMock.new)
    ..registerLazySingleton<IAuthService>(
      () => AuthServiceImpl(repository: locator(), tokenStorage: locator()),
    )
    ..registerFactory<AuthBloc>(() => AuthBloc(service: locator()))
    ..registerLazySingleton<ISlotsRepository>(SlotsRepositoryMock.new)
    ..registerLazySingleton<ISlotsService>(
      () => SlotsServiceImpl(repository: locator()),
    )
    ..registerFactory<SlotsBloc>(() => SlotsBloc(service: locator()))
    ..registerFactoryParam<SlotDetailBloc, String, void>(
      (slotId, _) => SlotDetailBloc(service: locator(), slotId: slotId),
    )
    ..registerLazySingleton<IBookingRepository>(BookingRepositoryMock.new)
    ..registerLazySingleton<IBookingService>(
      () => BookingServiceImpl(repository: locator()),
    )
    ..registerFactoryParam<BookingBloc, String, String>(
      (slotId, clientId) => BookingBloc(
        bookingService: locator(),
        slotsService: locator(),
        slotId: slotId,
        clientId: clientId,
      ),
    )
    ..registerLazySingleton<IMyBookingsService>(
      () => MyBookingsServiceImpl(
        bookingRepository: locator(),
        slotsRepository: locator(),
      ),
    )
    ..registerFactory<MyBookingsBloc>(() => MyBookingsBloc(service: locator()));
}
