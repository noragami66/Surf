abstract interface class IAuthRepository {
  Future<void> requestCode(String phone);

  Future<void> verifyCode({required String phone, required String code});

  Future<void> logout();
}
