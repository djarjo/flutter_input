// Copyright 2020 Hajo.Lemcke@gmail.com
// Please see the LICENSE file for details.

import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  String get i18n => localize(this, _t);

  // ignore: unused_field
  static final _t = Translations('en') +
      {
        'en': 'All users rating',
        'de': 'Bewertung aller Benutzer',
      } +
      {
        'en': 'Coffee Temperature',
        'de': 'Kaffee Temperatur',
      } +
      {
        'en': 'Country',
        'de': 'Land',
      } +
      {
        'en': 'Date',
        'de': 'Datum',
      } +
      {
        'en': 'Date & Time',
        'de': 'Datum & Zeit',
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
        'en': 'Misc',
        'de': 'Diverse',
      } +
      {
        'en': 'Mug size [ml]',
        'de': 'Bechergröße [ml]',
      } +
      {
        'en': 'Next Coffee Alarm',
        'de': 'Nächster Kaffee Wecker',
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
        'en': 'Select Language',
        'de': 'Sprache wählen',
      } +
      {
        'en': 'Settings',
        'de': 'Einstellungen',
      } +
      {
        'en': 'Somebodies birthday',
        'de': 'Geburtstag',
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
        'en': 'Thanks for using flutter_input!',
        'de': 'Danke für die Nutzung von flutter_input',
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
        'en': 'Time',
        'de': 'Zeit',
      } +
      {
        'en': 'Unit',
        'de': 'Einheit',
      } +
      {
        'en': 'You have pushed the button this many times:',
        'de': 'Du hast den Knopf so oft gedrückt',
      } +
      {
        'en': 'You must live somewhere',
        'de': 'Du musst irgendwo leben',
      };
}
