// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Глина';

  @override
  String get appTagline => 'Гончарная мастерская';

  @override
  String get slotsTab => 'Слоты';

  @override
  String get myBookingsTab => 'Мои записи';

  @override
  String get slotsSectionTitle => 'Расписание';

  @override
  String get slotsEmptyTitle => 'Пока нет доступных занятий';

  @override
  String get slotsEmptySubtitle => 'Загляните позже — расписание обновляется';

  @override
  String get slotsErrorTitle => 'Не удалось загрузить';

  @override
  String get slotsErrorSubtitle => 'Проверьте соединение и попробуйте снова';

  @override
  String slotsSeatsAvailable(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count мест',
      many: '$count мест',
      few: '$count места',
      one: '$count место',
    );
    return '$_temp0';
  }

  @override
  String get myBookingsSubtitle => 'Ваши бронирования и история';

  @override
  String get myBookingsEmptyTitle => 'Записей пока нет';

  @override
  String get myBookingsEmptySubtitle =>
      'Выберите занятие в расписании и забронируйте место';

  @override
  String get myBookingsGoToSchedule => 'Перейти к расписанию';

  @override
  String homeGreeting(String name) {
    return 'Привет, $name';
  }

  @override
  String get homeGreetingSubtitle => 'Рады видеть вас снова';

  @override
  String get loading => 'Загрузка…';

  @override
  String get authPhoneTitle => 'Добро пожаловать в Глину';

  @override
  String get authPhoneSubtitle =>
      'Введите номер телефона, чтобы войти или создать аккаунт';

  @override
  String get authPhoneLabel => 'Номер телефона';

  @override
  String get authPhoneHint => '+7 000 000 00 00';

  @override
  String get authContinue => 'Продолжить';

  @override
  String get authOtpTitle => 'Подтвердите номер';

  @override
  String authOtpSubtitle(String phone) {
    return 'Мы отправили 4-значный код на $phone';
  }

  @override
  String get authOtpHintMock => 'Код для мока: 0000';

  @override
  String get authVerify => 'Подтвердить';

  @override
  String get authChangeNumber => 'Изменить номер';

  @override
  String get authResendCode => 'Отправить код снова';

  @override
  String get authNameTitle => 'Как вас зовут?';

  @override
  String get authNameSubtitle =>
      'Добавьте имя, чтобы завершить настройку аккаунта';

  @override
  String get authNameLabel => 'Ваше имя';

  @override
  String get authNameHint => 'Анна';

  @override
  String get authFinish => 'Готово';

  @override
  String get authErrorInvalidPhone => 'Введите корректный номер телефона';

  @override
  String get authErrorInvalidCode => 'Неверный код. Попробуйте ещё раз';

  @override
  String get authErrorRateLimited => 'Слишком много попыток. Немного подождите';

  @override
  String get authErrorEmptyName => 'Пожалуйста, введите имя';

  @override
  String get authErrorNetwork => 'Ошибка сети. Попробуйте снова';

  @override
  String get authErrorGeneric => 'Что-то пошло не так. Попробуйте снова';

  @override
  String get logout => 'Выйти';
}
