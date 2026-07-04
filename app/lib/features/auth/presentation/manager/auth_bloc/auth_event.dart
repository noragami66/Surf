part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Checks secure storage for an existing session on launch (UC-6 startup).
final class AuthStarted extends AuthEvent {
  const AuthStarted();
}

/// UC-5.1 — request an OTP for [phone].
final class AuthCodeRequested extends AuthEvent {
  const AuthCodeRequested(this.phone);

  final String phone;

  @override
  List<Object?> get props => [phone];
}

/// UC-5.2 — verify the entered [code].
final class AuthCodeVerified extends AuthEvent {
  const AuthCodeVerified(this.code);

  final String code;

  @override
  List<Object?> get props => [code];
}

/// UC-5.3 — set the display name for a new client.
final class AuthNameSubmitted extends AuthEvent {
  const AuthNameSubmitted(this.name);

  final String name;

  @override
  List<Object?> get props => [name];
}

/// Logs the client out and drops the session.
final class AuthLoggedOut extends AuthEvent {
  const AuthLoggedOut();
}

/// Session dropped because refresh expired (UC-6 E1).
final class AuthSessionExpired extends AuthEvent {
  const AuthSessionExpired();
}

/// Returns the flow to the phone entry step (e.g. "change number").
final class AuthReset extends AuthEvent {
  const AuthReset();
}
