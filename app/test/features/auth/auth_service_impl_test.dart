import 'package:flutter_test/flutter_test.dart';
import 'package:glina/core/exception/app_exception.dart';
import 'package:glina/features/auth/application/auth_service_impl.dart';
import 'package:glina/features/auth/data/repositories/auth_repository_mock.dart';
import 'package:glina/features/auth/data/token_storage.dart';
import 'package:glina/features/auth/domain/entities/client_entity.dart';

/// In-memory [ITokenStorage] for tests (no platform channels).
class FakeTokenStorage implements ITokenStorage {
  String? access;
  String? refresh;
  ClientEntity? client;
  DateTime? accessExpiresAt;

  @override
  Future<void> clear() async {
    access = null;
    refresh = null;
    client = null;
    accessExpiresAt = null;
  }

  @override
  Future<String?> readAccessToken() async => access;

  @override
  Future<String?> readRefreshToken() async => refresh;

  @override
  Future<DateTime?> readAccessExpiresAt() async => accessExpiresAt;

  @override
  Future<ClientEntity?> readClient() async => client;

  @override
  Future<void> saveClient(ClientEntity value) async => client = value;

  @override
  Future<void> saveAccessExpiresAt(DateTime expiresAt) async {
    accessExpiresAt = expiresAt;
  }

  @override
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    access = accessToken;
    refresh = refreshToken;
  }
}

void main() {
  const phone = '+79991234567';

  group('AuthServiceImpl', () {
    late FakeTokenStorage storage;
    late AuthServiceImpl service;

    setUp(() {
      storage = FakeTokenStorage();
      service = AuthServiceImpl(
        repository: AuthRepositoryMock(),
        tokenStorage: storage,
      );
    });

    test('verifyCode persists tokens and client', () async {
      final session = await service.verifyCode(phone: phone, code: '0000');

      expect(session.isNew, isTrue);
      expect(storage.access, isNotEmpty);
      expect(storage.refresh, isNotEmpty);
      expect(storage.client, isNotNull);
      expect(storage.accessExpiresAt, isNotNull);
    });

    test('setName after verify updates the persisted client', () async {
      await service.verifyCode(phone: phone, code: '0000');

      final client = await service.setName('Anna');

      expect(client.name, 'Anna');
      expect(storage.client?.name, 'Anna');
    });

    test('setName before verify throws StateError', () {
      expect(() => service.setName('Anna'), throwsStateError);
    });

    test('restoreSession returns null when nothing is stored', () async {
      expect(await service.restoreSession(), isNull);
    });

    test('restoreSession returns the client when a token exists', () async {
      storage
        ..access = 'token'
        ..refresh = 'refresh'
        ..accessExpiresAt = DateTime.now().toUtc().add(const Duration(hours: 1))
        ..client = const ClientEntity(id: 'c1', phone: phone, name: 'Anna');

      final restored = await service.restoreSession();

      expect(restored?.name, 'Anna');
    });

    test('restoreSession refreshes when access token expired (UC-6)', () async {
      storage
        ..access = 'expired-token'
        ..refresh = 'valid-refresh'
        ..accessExpiresAt = DateTime.now().toUtc().subtract(
          const Duration(minutes: 1),
        )
        ..client = const ClientEntity(id: 'c1', phone: phone, name: 'Anna');

      final restored = await service.restoreSession();

      expect(restored?.name, 'Anna');
      expect(storage.access, isNot('expired-token'));
      expect(storage.accessExpiresAt, isNotNull);
      expect(
        storage.accessExpiresAt!.isAfter(DateTime.now().toUtc()),
        isTrue,
      );
    });

    test(
      'ensureValidSession throws when refresh is revoked (UC-6 E1)',
      () async {
      storage
        ..access = 'expired-token'
        ..refresh = 'mock-refresh-revoked'
        ..accessExpiresAt = DateTime.now().toUtc().subtract(
          const Duration(minutes: 1),
        )
        ..client = const ClientEntity(id: 'c1', phone: phone, name: 'Anna');

      await expectLater(
        service.ensureValidSession(),
        throwsA(isA<SessionExpiredException>()),
      );
      expect(storage.access, isNull);
      expect(storage.refresh, isNull);
    },
    );

    test('logout clears storage', () async {
      await service.verifyCode(phone: phone, code: '0000');

      await service.logout();

      expect(storage.access, isNull);
      expect(storage.client, isNull);
    });
  });
}
