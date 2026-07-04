import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glina/core/exception/app_exception.dart';
import 'package:glina/features/auth/application/i_auth_service.dart';
import 'package:glina/features/auth/domain/entities/auth_session.dart';
import 'package:glina/features/auth/domain/entities/client_entity.dart';
import 'package:glina/features/auth/presentation/manager/auth_bloc/auth_bloc.dart';
import 'package:mocktail/mocktail.dart';

class _MockAuthService extends Mock implements IAuthService {}

void main() {
  const phone = '+79991234567';
  const newClient = ClientEntity(id: 'c1', phone: phone, name: '');
  const namedClient = ClientEntity(id: 'c1', phone: phone, name: 'Anna');

  const newSession = AuthSession(
    accessToken: 'a',
    refreshToken: 'r',
    isNew: true,
    client: newClient,
  );
  const returningSession = AuthSession(
    accessToken: 'a',
    refreshToken: 'r',
    isNew: false,
    client: namedClient,
  );

  late IAuthService service;

  setUp(() => service = _MockAuthService());

  group('AuthStarted', () {
    blocTest<AuthBloc, AuthState>(
      'emits authenticated when a named client is restored',
      setUp: () =>
          when(service.restoreSession).thenAnswer((_) async => namedClient),
      build: () => AuthBloc(service: service),
      act: (bloc) => bloc.add(const AuthStarted()),
      expect: () => [
        isA<AuthState>().having(
          (s) => s.status,
          'status',
          AuthStatus.authenticated,
        ),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits unauthenticated when no session is stored',
      setUp: () => when(service.restoreSession).thenAnswer((_) async => null),
      build: () => AuthBloc(service: service),
      act: (bloc) => bloc.add(const AuthStarted()),
      expect: () => [
        isA<AuthState>().having(
          (s) => s.status,
          'status',
          AuthStatus.unauthenticated,
        ),
      ],
    );
  });

  group('AuthCodeRequested', () {
    blocTest<AuthBloc, AuthState>(
      'emits codeSent on success',
      setUp: () =>
          when(() => service.requestCode(phone)).thenAnswer((_) async {}),
      build: () => AuthBloc(service: service),
      act: (bloc) => bloc.add(const AuthCodeRequested(phone)),
      expect: () => [
        isA<AuthState>().having((s) => s.isSubmitting, 'submitting', true),
        isA<AuthState>()
            .having((s) => s.status, 'status', AuthStatus.codeSent)
            .having((s) => s.phone, 'phone', phone)
            .having((s) => s.isSubmitting, 'submitting', false),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits rate_limited error code on RateLimitedException',
      setUp: () => when(
        () => service.requestCode(phone),
      ).thenThrow(const RateLimitedException()),
      build: () => AuthBloc(service: service),
      act: (bloc) => bloc.add(const AuthCodeRequested(phone)),
      expect: () => [
        isA<AuthState>().having((s) => s.isSubmitting, 'submitting', true),
        isA<AuthState>().having(
          (s) => s.errorCode,
          'errorCode',
          'rate_limited',
        ),
      ],
    );
  });

  group('AuthCodeVerified', () {
    blocTest<AuthBloc, AuthState>(
      'emits needName for a new client',
      setUp: () => when(
        () => service.verifyCode(
          phone: any(named: 'phone'),
          code: '0000',
        ),
      ).thenAnswer((_) async => newSession),
      build: () => AuthBloc(service: service),
      seed: () => const AuthState(status: AuthStatus.codeSent, phone: phone),
      act: (bloc) => bloc.add(const AuthCodeVerified('0000')),
      expect: () => [
        isA<AuthState>().having((s) => s.isSubmitting, 'submitting', true),
        isA<AuthState>().having((s) => s.status, 'status', AuthStatus.needName),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits authenticated for a returning named client',
      setUp: () => when(
        () => service.verifyCode(
          phone: any(named: 'phone'),
          code: '0000',
        ),
      ).thenAnswer((_) async => returningSession),
      build: () => AuthBloc(service: service),
      seed: () => const AuthState(status: AuthStatus.codeSent, phone: phone),
      act: (bloc) => bloc.add(const AuthCodeVerified('0000')),
      expect: () => [
        isA<AuthState>().having((s) => s.isSubmitting, 'submitting', true),
        isA<AuthState>().having(
          (s) => s.status,
          'status',
          AuthStatus.authenticated,
        ),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits invalid_code error on wrong code',
      setUp: () => when(
        () => service.verifyCode(
          phone: any(named: 'phone'),
          code: '1111',
        ),
      ).thenThrow(const InvalidCodeException()),
      build: () => AuthBloc(service: service),
      seed: () => const AuthState(status: AuthStatus.codeSent, phone: phone),
      act: (bloc) => bloc.add(const AuthCodeVerified('1111')),
      expect: () => [
        isA<AuthState>().having((s) => s.isSubmitting, 'submitting', true),
        isA<AuthState>().having(
          (s) => s.errorCode,
          'errorCode',
          'invalid_code',
        ),
      ],
    );
  });

  group('AuthNameSubmitted', () {
    blocTest<AuthBloc, AuthState>(
      'emits authenticated after setting a name',
      setUp: () => when(
        () => service.setName('Anna'),
      ).thenAnswer((_) async => namedClient),
      build: () => AuthBloc(service: service),
      seed: () =>
          const AuthState(status: AuthStatus.needName, client: newClient),
      act: (bloc) => bloc.add(const AuthNameSubmitted('Anna')),
      expect: () => [
        isA<AuthState>().having((s) => s.isSubmitting, 'submitting', true),
        isA<AuthState>()
            .having((s) => s.status, 'status', AuthStatus.authenticated)
            .having((s) => s.client?.name, 'name', 'Anna'),
      ],
    );
  });

  group('AuthLoggedOut', () {
    blocTest<AuthBloc, AuthState>(
      'emits unauthenticated after logout',
      setUp: () => when(service.logout).thenAnswer((_) async {}),
      build: () => AuthBloc(service: service),
      seed: () => const AuthState.authenticated(namedClient),
      act: (bloc) => bloc.add(const AuthLoggedOut()),
      expect: () => [
        isA<AuthState>().having(
          (s) => s.status,
          'status',
          AuthStatus.unauthenticated,
        ),
      ],
    );
  });
}
