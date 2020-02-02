// Copyright 2020 Hajo.Lemcke@gmail.com
// Please see the LICENSE file for details.

import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  String get i18n => localize(this, _t);

  static final _t = Translations('en') +
      {
        'en': 'All users rating',
        'de': 'Bewertung aller Benutzer',
      } +
      {
        'en': 'Country',
        'de': 'Land',
      } +
      {
        'en': 'Editable int',
        'de': 'Zahleneingabe',
      } +
      {
        'en': 'Exit without any changes',
        'de': 'Abbruch ohne Änderungen',
      } +
      {
        'en': 'Field values saved back to map',
        'de': 'Änderungen wurden gespeichert',
      } +
      {
        'en': 'Mug size [ml]',
        'de': 'Bechergröße [ml]',
      } +
      {
        'en': '<Please select a country>',
        'de': '<Bitte ein Land auswählen>',
      } +
      {
        'en': '<Please select the SI unit>',
        'de': '<Bitte die SI Einheit wählen>',
      } +
      {
        'en': 'Save changes and leave edit mode',
        'de': 'Änderungen speichern',
      } +
      {
        'en': 'Switch to datetime page',
        'de': 'Wechsel zur Seite mit Datum und Zeit',
      } +
      {
        'en': 'Thanks',
        'de': 'Besten Dank',
      } +
      {
        'en': 'This coffee is frozen',
        'de': 'Dieser Kaffe ist gefroren',
      } +
      {
        'en': 'This is only steam',
        'de': 'Das ist nur noch Dampf',
      } +
      {
        'en': 'Unit',
        'de': 'Einheit',
      } +
      {
        'en': 'You must live somewhere',
        'de': 'Du musst irgendwo leben',
      };
}
