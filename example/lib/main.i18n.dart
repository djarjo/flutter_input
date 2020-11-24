// Copyright 2020 Hajo.Lemcke@gmail.com
// Please see the LICENSE file for details.

import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  String get i18n => localize(this, _t);

  // ignore: unused_field
  static final _t = Translations('en') +
      {
        'en_us': 'Date',
        'de_de': 'Datum',
      } +
      {
        'en': 'Settings',
        'de': 'Einstellungen',
      } +
      {
        'en': 'Thanks for using flutter_input!',
        'de': 'Vielen Dank für die Nutzung von flutter_input',
      };
}
