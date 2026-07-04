import 'package:glina/features/auth/domain/entities/auth_session.dart';
import 'package:glina/features/auth/domain/entities/client_entity.dart';

/// Auth use-case orchestration (BLoC talks to this, never to the repository).
abstract interface class IAuthService {
  /// Returns the persisted client if a valid session exists (UC-6 startup).
  Future<ClientEntity?> restoreSession();

  /// Requests an OTP for [phone] (UC-5.1).
  Future<void> requestCode(String phone);

  /// Verifies [code], persists tokens, returns the session (UC-5.2).
  Future<AuthSession> verifyCode({required String phone, required String code});

  /// Sets the display name for a new client (UC-5.3).
  Future<ClientEntity> setName(String name);

  /// Clears session and secure storage (logout).
  Future<void> logout();
}
