import 'package:glina/features/auth/application/i_auth_service.dart';
import 'package:glina/features/auth/data/token_storage.dart';
import 'package:glina/features/auth/domain/repositories/i_auth_repository.dart';

class AuthServiceImpl implements IAuthService {
  AuthServiceImpl({
    required IAuthRepository repository,
    required ITokenStorage tokenStorage,
  }) : _repository = repository,
       _tokenStorage = tokenStorage;

  final IAuthRepository _repository;
  final ITokenStorage _tokenStorage;

  @override
  Future<void> logout() async {
    await _repository.logout();
    await _tokenStorage.clear();
  }

  @override
  Future<void> requestCode(String phone) => _repository.requestCode(phone);

  @override
  Future<void> verifyCode({
    required String phone,
    required String code,
  }) async {
    await _repository.verifyCode(phone: phone, code: code);
    await _tokenStorage.saveTokens(
      accessToken: 'mock-access',
      refreshToken: 'mock-refresh',
    );
  }
}
