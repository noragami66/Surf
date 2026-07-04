/// Base application exception.
sealed class AppException implements Exception {
  const AppException(this.code, this.message);

  /// Machine-readable error code (matches api-contract error codes).
  final String code;

  /// Human-readable fallback message (UI prefers l10n by [code]).
  final String message;

  @override
  String toString() => message;
}

/// OTP code did not match (UC-5 E1).
final class InvalidCodeException extends AppException {
  const InvalidCodeException()
    : super('invalid_code', 'The confirmation code is incorrect');
}

/// Too many code requests in a short window (UC-5 E2).
final class RateLimitedException extends AppException {
  const RateLimitedException()
    : super('rate_limited', 'Too many attempts, please wait');
}

/// Refresh token expired — session must be dropped (UC-6 E1).
final class SessionExpiredException extends AppException {
  const SessionExpiredException()
    : super('refresh_expired', 'Session expired, please sign in again');
}

/// Generic network failure (UC-5/UC-6 E — offline).
final class NetworkException extends AppException {
  const NetworkException()
    : super('network_error', 'Network error, please try again');
}
