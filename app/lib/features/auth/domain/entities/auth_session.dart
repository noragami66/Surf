import 'package:equatable/equatable.dart';
import 'package:glina/features/auth/domain/entities/client_entity.dart';

/// Result of a successful OTP verification / refresh (api-contract verify-code).
class AuthSession extends Equatable {
  const AuthSession({
    required this.accessToken,
    required this.refreshToken,
    required this.isNew,
    required this.client,
  });

  final String accessToken;
  final String refreshToken;

  /// `is_new` — client must provide a name before entering the app (UC-5.3).
  final bool isNew;

  final ClientEntity client;

  @override
  List<Object?> get props => [accessToken, refreshToken, isNew, client];
}
