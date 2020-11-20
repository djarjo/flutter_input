// Copyright 2020 Hajo.Lemcke@gmail.com
// Please see the LICENSE file for details.

import 'package:i18n_extension/i18n_extension.dart';

/// Localizations for `InputLanguage`
///
/// Supported languages:
/// * de
/// * en
extension Localization on String {
  String get i18n => localize(this, _t);

  static final _t = Translations('en') +
      {
        'en': 'From device',
        'de': 'Gerätesprache',
      } +
      {
        'en': 'danish',
        'de': 'dänisch',
      } +
      {
        'en': 'english',
        'de': 'englisch',
      } +
      {
        'en': 'french',
        'de': 'französisch',
      } +
      {
        'en': 'german',
        'de': 'deutsch',
      } +
      {
        'en': 'italian',
        'de': 'italienisch',
      } +
      {
        'en': 'japanese',
        'de': 'japanisch',
      } +
      {
        'en': 'portuguese',
        'de': 'portugiesisch',
      } +
      {
        'en': 'spain',
        'de': 'spanisch',
      } +
      {
        'en': 'swedish',
        'de': 'schwedisch',
      };
}
