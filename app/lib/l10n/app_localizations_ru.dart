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
  String get slotsTab => 'Слоты';

  @override
  String get myBookingsTab => 'Мои записи';

  @override
  String get slotsEmptyTitle => 'Пока нет доступных занятий';

  @override
  String get loading => 'Загрузка…';
}
