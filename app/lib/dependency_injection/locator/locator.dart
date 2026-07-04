import 'package:get_it/get_it.dart';
import 'package:glina/features/auth/application/auth_service_impl.dart';
import 'package:glina/features/auth/application/i_auth_service.dart';
import 'package:glina/features/auth/data/repositories/auth_repository_mock.dart';
import 'package:glina/features/auth/data/secure_token_storage.dart';
import 'package:glina/features/auth/data/token_storage.dart';
import 'package:glina/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:glina/features/auth/presentation/manager/auth_bloc/auth_bloc.dart';
import 'package:glina/features/slots/application/i_slots_service.dart';
import 'package:glina/features/slots/application/slots_service_impl.dart';
import 'package:glina/features/slots/data/repositories/slots_repository_mock.dart';
import 'package:glina/features/slots/domain/repositories/i_slots_repository.dart';
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
    ..registerFactory<SlotsBloc>(() => SlotsBloc(service: locator()));
}
