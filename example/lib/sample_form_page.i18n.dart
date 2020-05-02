// Copyright 2020 Hajo.Lemcke@gmail.com
// Please see the LICENSE file for details.

import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  String get i18n => localize(this, _t);

  // ignore: unused_field
  static final _t = Translations('en_us') +
      {
        'en_us': 'All users rating',
        'de_de': 'Bewertung aller Benutzer',
      } +
      {
        'en_us': 'Country',
        'de_de': 'Land',
      } +
      {
        'en_us': 'Date',
        'de_de': 'Datum',
      } +
      {
        'en_us': 'Date & Time',
        'de_de': 'Datum & Zeit',
      } +
      {
        'en_us': 'Date and time format selection',
        'de_de': 'Auswahl von Datum und / oder Zeit',
      } +
      {
        'en_us': 'DateTime Page',
        'de_de': 'Die zeitliche Seite',
      } +
      {
        'en_us': 'Editable int',
        'de_de': 'Zahleneingabe',
      } +
      {
        'en_us': 'Exit without any changes',
        'de_de': 'Abbruch ohne Änderungen',
      } +
      {
        'en_us': 'Field values saved back to map',
        'de_de': 'Änderungen wurden gespeichert',
      } +
      {
        'en_us': 'Misc',
        'de_de': 'Diverse',
      } +
      {
        'en_us': 'Mug size [ml]',
        'de_de': 'Bechergröße [ml]',
      } +
      {
        'en_us': 'Next Coffee Alarm',
        'de_de': 'Nächster Kaffee Wecker',
      } +
      {
        'en_us': '<Please select a country>',
        'de_de': '<Bitte ein Land auswählen>',
      } +
      {
        'en_us': '<Please select the SI unit>',
        'de_de': '<Bitte die SI Einheit wählen>',
      } +
      {
        'en_us': 'Save changes and leave edit mode',
        'de_de': 'Änderungen speichern',
      } +
      {
        'en_us': 'Select Language',
        'de_de': 'Sprache wählen',
      } +
      {
        'en_us': 'Settings',
        'de_de': 'Einstellungen',
      } +
      {
        'en_us': 'Somebodies birthday',
        'de_de': 'Geburtstag',
      } +
      {
        'en_us': 'Switch to datetime page',
        'de_de': 'Wechsel zur Seite mit Datum und Zeit',
      } +
      {
        'en_us': 'Thanks',
        'de_de': 'Besten Dank',
      } +
      {
        'en_us': 'Thanks for using flutter_input!',
        'de_de': 'Danke für die Nutzung von flutter_input',
      } +
      {
        'en_us': 'This coffee is frozen',
        'de_de': 'Dieser Kaffe ist gefroren',
      } +
      {
        'en_us': 'This is only steam',
        'de_de': 'Das ist nur noch Dampf',
      } +
      {
        'en_us': 'Time',
        'de_de': 'Zeit',
      } +
      {
        'en_us': 'Unit',
        'de_de': 'Einheit',
      } +
      {
        'en_us': 'You have pushed the button this many times:',
        'de_de': 'Du hast den Knopf so oft gedrückt',
      } +
      {
        'en_us': 'You must live somewhere',
        'de_de': 'Du musst irgendwo leben',
      };
}
