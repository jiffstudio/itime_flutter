import 'dart:ui';
import 'package:intl/intl.dart';
import 'l10n.dart';

extension GenerateLocaleDelegate on S{
  static AppLocalizationDelegate getLocaleDelegate(Locale locale){
    return LocaleDelegate(locale: locale);
  }
  /// `Chicken egg`
  String additive(String key) {
    return Intl.message(
      'Chicken egg',
      name: 'canteen_additive_$key',
      desc: '',
      args: [],
    );
  }
}

class LocaleDelegate extends AppLocalizationDelegate{
  final Locale? locale;
  const LocaleDelegate({this.locale});
  @override
  Future<S> load(Locale locale) {
    return super.load(this.locale ?? locale);
  }
}
