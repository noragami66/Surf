import 'package:glina/features/auth/application/i_auth_service.dart';
import 'package:glina/features/auth/domain/entities/auth_session.dart';
import 'package:glina/features/auth/domain/entities/client_entity.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthService extends Mock implements IAuthService {}

const _stubClient = ClientEntity(
  id: 'c1',
  phone: '+70000000000',
  name: 'Test',
);

const _stubSession = AuthSession(
  accessToken: 'a',
  refreshToken: 'r',
  expiresIn: 3600,
  isNew: false,
  client: _stubClient,
);

/// Registers a no-op [IAuthService.ensureValidSession] for service unit tests.
MockAuthService stubAuthService() {
  registerFallbackValue('');
  final authService = MockAuthService();
  when(authService.ensureValidSession).thenAnswer((_) async {});
  when(authService.restoreSession).thenAnswer((_) async => null);
  when(() => authService.requestCode(any())).thenAnswer((_) async {});
  when(
    () => authService.verifyCode(
      phone: any(named: 'phone'),
      code: any(named: 'code'),
    ),
  ).thenAnswer((_) async => _stubSession);
  when(() => authService.setName(any())).thenAnswer((_) async => _stubClient);
  when(authService.logout).thenAnswer((_) async {});
  return authService;
}
