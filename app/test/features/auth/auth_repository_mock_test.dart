import 'package:flutter_test/flutter_test.dart';
import 'package:glina/core/exception/app_exception.dart';
import 'package:glina/features/auth/data/repositories/auth_repository_mock.dart';

void main() {
  const phone = '+79991234567';

  group('AuthRepositoryMock', () {
    late AuthRepositoryMock repository;

    setUp(() => repository = AuthRepositoryMock());

    test('verifyCode with 0000 returns a new client on first login', () async {
      final session = await repository.verifyCode(phone: phone, code: '0000');

      expect(session.isNew, isTrue);
      expect(session.client.phone, phone);
      expect(session.client.name, isEmpty);
      expect(session.accessToken, isNotEmpty);
      expect(session.refreshToken, isNotEmpty);
    });

    test('verifyCode with wrong code throws InvalidCodeException', () {
      expect(
        () => repository.verifyCode(phone: phone, code: '1111'),
        throwsA(isA<InvalidCodeException>()),
      );
    });

    test('second login for the same phone is not new', () async {
      final first = await repository.verifyCode(phone: phone, code: '0000');
      await repository.setName(clientId: first.client.id, name: 'Anna');

      final second = await repository.verifyCode(phone: phone, code: '0000');

      expect(second.isNew, isFalse);
      expect(second.client.name, 'Anna');
    });

    test('setName updates the stored client name', () async {
      final session = await repository.verifyCode(phone: phone, code: '0000');

      final updated = await repository.setName(
        clientId: session.client.id,
        name: '  Boris  ',
      );

      expect(updated.name, 'Boris');
    });

    test('exceeding the request limit throws RateLimitedException', () async {
      for (var i = 0; i < 5; i++) {
        await repository.requestCode(phone);
      }

      expect(
        () => repository.requestCode(phone),
        throwsA(isA<RateLimitedException>()),
      );
    });
  });
}
