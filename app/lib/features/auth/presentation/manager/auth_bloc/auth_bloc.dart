import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glina/core/exception/app_exception.dart';
import 'package:glina/features/auth/application/i_auth_service.dart';
import 'package:glina/features/auth/domain/entities/client_entity.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required IAuthService service})
    : _service = service,
      super(const AuthState.unknown()) {
    on<AuthStarted>(_onStarted);
    on<AuthCodeRequested>(_onCodeRequested);
    on<AuthCodeVerified>(_onCodeVerified);
    on<AuthNameSubmitted>(_onNameSubmitted);
    on<AuthLoggedOut>(_onLoggedOut);
    on<AuthSessionExpired>(_onSessionExpired);
    on<AuthReset>(_onReset);
  }

  final IAuthService _service;

  Future<void> _onStarted(AuthStarted event, Emitter<AuthState> emit) async {
    final client = await _service.restoreSession();
    if (client != null && client.hasName) {
      emit(AuthState.authenticated(client));
    } else {
      emit(const AuthState.unauthenticated());
    }
  }

  Future<void> _onCodeRequested(
    AuthCodeRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isSubmitting: true, clearError: true));
    try {
      await _service.requestCode(event.phone);
      emit(
        state.copyWith(
          status: AuthStatus.codeSent,
          phone: event.phone,
          isSubmitting: false,
        ),
      );
    } on AppException catch (error) {
      emit(state.copyWith(isSubmitting: false, errorCode: error.code));
    }
  }

  Future<void> _onCodeVerified(
    AuthCodeVerified event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isSubmitting: true, clearError: true));
    try {
      final session = await _service.verifyCode(
        phone: state.phone,
        code: event.code,
      );
      if (session.isNew || !session.client.hasName) {
        emit(
          state.copyWith(
            status: AuthStatus.needName,
            client: session.client,
            isSubmitting: false,
          ),
        );
      } else {
        emit(AuthState.authenticated(session.client));
      }
    } on AppException catch (error) {
      emit(state.copyWith(isSubmitting: false, errorCode: error.code));
    }
  }

  Future<void> _onNameSubmitted(
    AuthNameSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isSubmitting: true, clearError: true));
    try {
      final client = await _service.setName(event.name);
      emit(AuthState.authenticated(client));
    } on AppException catch (error) {
      emit(state.copyWith(isSubmitting: false, errorCode: error.code));
    }
  }

  Future<void> _onLoggedOut(
    AuthLoggedOut event,
    Emitter<AuthState> emit,
  ) async {
    await _service.logout();
    emit(const AuthState.unauthenticated());
  }

  Future<void> _onSessionExpired(
    AuthSessionExpired event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.unauthenticated());
  }

  void _onReset(AuthReset event, Emitter<AuthState> emit) {
    emit(const AuthState.unauthenticated());
  }
}
