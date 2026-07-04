import 'package:glina/core/auth/session_auth_bridge.dart';
import 'package:glina/core/exception/app_exception.dart';
import 'package:glina/features/auth/application/i_auth_service.dart';
import 'package:glina/features/auth/data/token_storage.dart';
import 'package:glina/features/auth/domain/entities/auth_session.dart';
import 'package:glina/features/auth/domain/entities/client_entity.dart';
import 'package:glina/features/auth/domain/repositories/i_auth_repository.dart';

/// Refresh slightly before expiry to avoid 401 on in-flight requests (UC-6).
const _accessTokenSkew = Duration(seconds: 30);

class AuthServiceImpl implements IAuthService {
  AuthServiceImpl({
    required IAuthRepository repository,
    required ITokenStorage tokenStorage,
    SessionAuthBridge? sessionBridge,
  }) : _repository = repository,
       _tokenStorage = tokenStorage,
       _sessionBridge = sessionBridge ?? SessionAuthBridge();

  final IAuthRepository _repository;
  final ITokenStorage _tokenStorage;
  final SessionAuthBridge _sessionBridge;

  /// Current client held for the setName step (UC-5.3).
  ClientEntity? _currentClient;

  @override
  Future<ClientEntity?> restoreSession() async {
    final client = await _tokenStorage.readClient();
    if (client == null) {
      return null;
    }

    final refresh = await _tokenStorage.readRefreshToken();
    if (refresh == null || refresh.isEmpty) {
      return null;
    }

    try {
      await ensureValidSession();
    } on SessionExpiredException {
      return null;
    }

    _currentClient = client;
    return client.hasName ? client : null;
  }

  @override
  Future<void> ensureValidSession() async {
    final refresh = await _tokenStorage.readRefreshToken();
    if (refresh == null || refresh.isEmpty) {
      await _dropSession();
      throw const SessionExpiredException();
    }

    if (await _isAccessTokenValid()) {
      return;
    }

    await _refreshAndPersist(refresh);
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
    await _dropSession();
  }

  Future<bool> _isAccessTokenValid() async {
    final access = await _tokenStorage.readAccessToken();
    if (access == null || access.isEmpty) {
      return false;
    }
    final expiresAt = await _tokenStorage.readAccessExpiresAt();
    if (expiresAt == null) {
      return false;
    }
    return DateTime.now().toUtc().isBefore(
      expiresAt.subtract(_accessTokenSkew),
    );
  }

  Future<void> _refreshAndPersist(String refreshToken) async {
    try {
      final session = await _repository.refresh(refreshToken);
      _currentClient = session.client;
      await _persist(session);
    } on SessionExpiredException {
      await _dropSession();
      rethrow;
    }
  }

  Future<void> _persist(AuthSession session) async {
    await _tokenStorage.saveTokens(
      accessToken: session.accessToken,
      refreshToken: session.refreshToken,
    );
    await _tokenStorage.saveAccessExpiresAt(
      DateTime.now().toUtc().add(Duration(seconds: session.expiresIn)),
    );
    await _tokenStorage.saveClient(session.client);
  }

  Future<void> _dropSession() async {
    await _tokenStorage.clear();
    _currentClient = null;
    _sessionBridge.notifySessionExpired();
  }
}
