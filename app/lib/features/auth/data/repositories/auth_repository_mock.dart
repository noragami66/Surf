import 'package:glina/features/auth/domain/repositories/i_auth_repository.dart';

class AuthRepositoryMock implements IAuthRepository {
  @override
  Future<void> logout() async {}

  @override
  Future<void> requestCode(String phone) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
  }

  @override
  Future<void> verifyCode({
    required String phone,
    required String code,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
  }
}
