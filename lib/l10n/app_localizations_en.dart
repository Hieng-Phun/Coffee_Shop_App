// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get welcomeMessage => 'Welcome!';

  @override
  String get selectCoffeeTitle => 'Select your coffee';

  @override
  String get changeLanguageTitle => 'Change Language';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageKhmer => 'Khmer';

  @override
  String get americanoName => 'Americano';

  @override
  String get cappuccinoName => 'Cappuccino';

  @override
  String get latteName => 'Latte';

  @override
  String get flatWhiteName => 'Flat White';

  @override
  String get rafName => 'Raf';

  @override
  String get espressoName => 'Espresso';
}
