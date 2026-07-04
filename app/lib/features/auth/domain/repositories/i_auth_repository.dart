import 'package:glina/features/auth/domain/entities/auth_session.dart';
import 'package:glina/features/auth/domain/entities/client_entity.dart';

/// Auth data-source contract (api-contract `/auth/*`).
abstract interface class IAuthRepository {
  /// POST /auth/request-code — sends OTP to [phone].
  Future<void> requestCode(String phone);

  /// POST /auth/verify-code — exchanges [code] for a session.
  Future<AuthSession> verifyCode({required String phone, required String code});

  /// PATCH /profile — sets the display name for a new client.
  Future<ClientEntity> setName({
    required String clientId,
    required String name,
  });

  /// POST /auth/refresh — rotates tokens using [refreshToken].
  Future<AuthSession> refresh(String refreshToken);

  /// POST /auth/logout — invalidates the current session.
  Future<void> logout();
}
