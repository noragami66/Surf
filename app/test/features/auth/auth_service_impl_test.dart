import 'package:flutter_test/flutter_test.dart';
import 'package:glina/features/auth/application/auth_service_impl.dart';
import 'package:glina/features/auth/data/repositories/auth_repository_mock.dart';
import 'package:glina/features/auth/data/token_storage.dart';
import 'package:glina/features/auth/domain/entities/client_entity.dart';

/// In-memory [ITokenStorage] for tests (no platform channels).
class _FakeTokenStorage implements ITokenStorage {
  String? access;
  String? refresh;
  ClientEntity? client;

  @override
  Future<void> clear() async {
    access = null;
    refresh = null;
    client = null;
  }

  @override
  Future<String?> readAccessToken() async => access;

  @override
  Future<String?> readRefreshToken() async => refresh;

  @override
  Future<ClientEntity?> readClient() async => client;

  @override
  Future<void> saveClient(ClientEntity value) async => client = value;

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
    late _FakeTokenStorage storage;
    late AuthServiceImpl service;

    setUp(() {
      storage = _FakeTokenStorage();
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
        ..client = const ClientEntity(id: 'c1', phone: phone, name: 'Anna');

      final restored = await service.restoreSession();

      expect(restored?.name, 'Anna');
    });

    test('logout clears storage', () async {
      await service.verifyCode(phone: phone, code: '0000');

      await service.logout();

      expect(storage.access, isNull);
      expect(storage.client, isNull);
    });
  });
}
