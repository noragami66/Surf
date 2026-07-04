part of 'auth_bloc.dart';

enum AuthStatus {
  /// Session not yet resolved (splash).
  unknown,

  /// No session — phone entry.
  unauthenticated,

  /// OTP sent — code entry.
  codeSent,

  /// New client — name entry.
  needName,

  /// Fully authenticated.
  authenticated,
}

final class AuthState extends Equatable {
  const AuthState({
    required this.status,
    this.phone = '',
    this.client,
    this.errorCode,
    this.isSubmitting = false,
  });

  const AuthState.unknown() : this(status: AuthStatus.unknown);

  const AuthState.unauthenticated() : this(status: AuthStatus.unauthenticated);

  const AuthState.authenticated(ClientEntity client)
    : this(status: AuthStatus.authenticated, client: client);

  final AuthStatus status;
  final String phone;
  final ClientEntity? client;

  /// Machine-readable error code (mapped to l10n in the UI).
  final String? errorCode;

  final bool isSubmitting;

  bool get isAuthenticated => status == AuthStatus.authenticated;

  AuthState copyWith({
    AuthStatus? status,
    String? phone,
    ClientEntity? client,
    String? errorCode,
    bool clearError = false,
    bool? isSubmitting,
  }) {
    return AuthState(
      status: status ?? this.status,
      phone: phone ?? this.phone,
      client: client ?? this.client,
      errorCode: clearError ? null : (errorCode ?? this.errorCode),
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  @override
  List<Object?> get props => [status, phone, client, errorCode, isSubmitting];
}
