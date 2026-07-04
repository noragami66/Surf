import 'package:glina/core/exception/app_exception.dart';
import 'package:glina/features/auth/data/mappers/auth_mapper.dart';
import 'package:glina/features/auth/data/models/auth_tokens_model.dart';
import 'package:glina/features/auth/domain/entities/auth_session.dart';
import 'package:glina/features/auth/domain/entities/client_entity.dart';
import 'package:glina/features/auth/domain/repositories/i_auth_repository.dart';

/// In-memory auth mock (Mock-стратегия §6): valid OTP is `0000`.
class AuthRepositoryMock implements IAuthRepository {
  static const _validCode = '0000';
  static const _maxRequestsPerPhone = 5;
  static const _latency = Duration(milliseconds: 300);

  /// phone -> known client (simulates the backend user table).
  final Map<String, ClientEntity> _clients = {};

  /// phone -> code request counter (drives the rate-limit exception, UC-5 E2).
  final Map<String, int> _requestCounts = {};

  var _tokenSeq = 0;

  @override
  Future<void> requestCode(String phone) async {
    await Future<void>.delayed(_latency);
    final count = (_requestCounts[phone] ?? 0) + 1;
    _requestCounts[phone] = count;
    if (count > _maxRequestsPerPhone) {
      throw const RateLimitedException();
    }
  }

  @override
  Future<AuthSession> verifyCode({
    required String phone,
    required String code,
  }) async {
    await Future<void>.delayed(_latency);
    if (code != _validCode) {
      throw const InvalidCodeException();
    }

    _requestCounts.remove(phone);

    final existing = _clients[phone];
    final isNew = existing == null;
    final client =
        existing ??
        ClientEntity(
          id: 'client-${_clients.length + 1}',
          phone: phone,
          name: '',
        );
    _clients[phone] = client;

    return _issueTokens(client: client, isNew: isNew);
  }

  @override
  Future<ClientEntity> setName({
    required String clientId,
    required String name,
  }) async {
    await Future<void>.delayed(_latency);
    final entry = _clients.entries.firstWhere(
      (e) => e.value.id == clientId,
      orElse: () => throw const NetworkException(),
    );
    final updated = entry.value.copyWith(name: name.trim());
    _clients[entry.key] = updated;
    return updated;
  }

  @override
  Future<AuthSession> refresh(String refreshToken) async {
    await Future<void>.delayed(_latency);
    // Mock always accepts a non-empty refresh token.
    if (refreshToken.isEmpty) {
      throw const SessionExpiredException();
    }
    final client = _clients.values.isNotEmpty
        ? _clients.values.last
        : const ClientEntity(id: 'client-1', phone: '', name: '');
    return _issueTokens(client: client, isNew: false);
  }

  @override
  Future<void> logout() async {
    await Future<void>.delayed(_latency);
  }

  AuthSession _issueTokens({
    required ClientEntity client,
    required bool isNew,
  }) {
    _tokenSeq++;
    final model = AuthTokensModel.fromJson({
      'access_token': 'mock-access-$_tokenSeq',
      'refresh_token': 'mock-refresh-$_tokenSeq',
      'expires_in': 3600,
      'refresh_expires_in': 2592000,
      'is_new': isNew,
      'client': {'id': client.id, 'name': client.name, 'phone': client.phone},
    });
    return model.toEntity();
  }
}
