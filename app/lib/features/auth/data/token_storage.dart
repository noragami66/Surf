import 'package:glina/features/auth/domain/entities/client_entity.dart';

/// Secure persistence for the auth session (R-025).
abstract interface class ITokenStorage {
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  });

  Future<String?> readAccessToken();

  Future<String?> readRefreshToken();

  /// Persists the authenticated client (used to restore session on launch).
  Future<void> saveClient(ClientEntity client);

  Future<ClientEntity?> readClient();

  Future<void> clear();
}
