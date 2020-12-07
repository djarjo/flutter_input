// Copyright 2020 Hajo.Lemcke@gmail.com
// Please see the LICENSE file for details.

import 'package:i18n_extension/i18n_extension.dart';

/// Localizations for `Country`
///
/// Supported languages:
/// * de
/// * en
extension Localization on String {
  String get i18n => localize(this, _t);

  static final _t = Translations('en') +
      {
        'en': 'Australia',
        'de': 'Australien',
      } +
      {
        'en': 'Austria',
        'de': 'Österreich',
      } +
      {
        'en': 'Belgium',
        'de': 'Belgien',
      } +
      {
        'en': 'Brazil',
        'de': 'Brasilien',
      } +
      {
        'en': 'Canada',
        'de': 'Kanada',
      } +
      {
        'en': 'China',
        'de': 'China',
      } +
      {
        'en': 'France',
        'de': 'Frankreich',
      } +
      {
        'en': 'Germany',
        'de': 'Deutschland',
      } +
      {
        'en': 'Great Britain',
        'de': 'Großbritannien',
      } +
      {
        'en': 'India',
        'de': 'Indien',
      } +
      {
        'en': 'Italy',
        'de': 'Italien',
      } +
      {
        'en': 'Netherlands',
        'de': 'Niederlande',
      } +
      {
        'en': 'Japan',
        'de': 'Japan',
      } +
      {
        'en': 'Spain',
        'de': 'Spanien',
      } +
      {
        'en': 'U.S.A.',
        'de': 'U.S.A.',
      };
}
