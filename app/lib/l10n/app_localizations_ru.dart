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
  String get loading => 'Загрузка…';
}
