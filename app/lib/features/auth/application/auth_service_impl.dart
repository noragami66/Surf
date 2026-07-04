import 'package:glina/features/auth/application/i_auth_service.dart';
import 'package:glina/features/auth/data/token_storage.dart';
import 'package:glina/features/auth/domain/entities/auth_session.dart';
import 'package:glina/features/auth/domain/entities/client_entity.dart';
import 'package:glina/features/auth/domain/repositories/i_auth_repository.dart';

class AuthServiceImpl implements IAuthService {
  AuthServiceImpl({
    required IAuthRepository repository,
    required ITokenStorage tokenStorage,
  }) : _repository = repository,
       _tokenStorage = tokenStorage;

  final IAuthRepository _repository;
  final ITokenStorage _tokenStorage;

  /// Current client held for the setName step (UC-5.3).
  ClientEntity? _currentClient;

  @override
  Future<ClientEntity?> restoreSession() async {
    final access = await _tokenStorage.readAccessToken();
    if (access == null || access.isEmpty) {
      return null;
    }
    final client = await _tokenStorage.readClient();
    _currentClient = client;
    return client;
  }

  @override
  Future<void> requestCode(String phone) => _repository.requestCode(phone);

  @override
  Future<AuthSession> verifyCode({
    required String phone,
    required String code,
  }) async {
    final session = await _repository.verifyCode(phone: phone, code: code);
    _currentClient = session.client;
    await _persist(session);
    return session;
  }

  @override
  Future<ClientEntity> setName(String name) async {
    final client = _currentClient;
    if (client == null) {
      throw StateError('setName called before a session was established');
    }
    final updated = await _repository.setName(clientId: client.id, name: name);
    _currentClient = updated;
    await _tokenStorage.saveClient(updated);
    return updated;
  }

  @override
  Future<void> logout() async {
    await _repository.logout();
    await _tokenStorage.clear();
    _currentClient = null;
  }

  Future<void> _persist(AuthSession session) async {
    await _tokenStorage.saveTokens(
      accessToken: session.accessToken,
      refreshToken: session.refreshToken,
    );
    await _tokenStorage.saveClient(session.client);
  }
}
