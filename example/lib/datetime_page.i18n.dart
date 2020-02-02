// Copyright 2020 Hajo.Lemcke@gmail.com
// Please see the LICENSE file for details.

import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  String get i18n => localize(this, _t);

  static final _t = Translations('en') +
      {
        'en': 'Date',
        'de': 'Datum',
      } +
      {
        'en': 'Date & Time',
        'de': 'Datum und Zeit',
      } +
      {
        'en': 'Date and time format selection',
        'de': 'Auswahl von Datum und / oder Zeit',
      } +
      {
        'en': 'DateTime Page',
        'de': 'Die zeitliche Seite',
      } +
      {
        'en': 'Next Coffee Alarm',
        'de': 'Nächster Kaffee Wecker',
      } +
      {
        'en': 'Somebodies birthday',
        'de': 'Geburtstag',
      } +
      {
        'en': 'Time',
        'de': 'Zeit',
      } +
      {
        'en': 'You have pushed the button this many times:',
        'de': 'Du hast den Knopf so oft gedrückt',
      };
}
