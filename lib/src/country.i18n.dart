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
}

final _t = Translations('en_us') +
    {
      'en_us': 'Australia',
      'de_de': 'Australien',
    } +
    {
      'en_us': 'Brazil',
      'de_de': 'Brasilien',
    } +
    {
      'en_us': 'China',
      'de_de': 'China',
    } +
    {
      'en_us': 'France',
      'de_de': 'Frankreich',
    } +
    {
      'en_us': 'Germany',
      'de_de': 'Deutschland',
    } +
    {
      'en_us': 'Great Britain',
      'de_de': 'Großbritannien',
    } +
    {
      'en_us': 'India',
      'de_de': 'Indien',
    } +
    {
      'en_us': 'Italy',
      'de_de': 'Italien',
    } +
    {
      'en_us': 'Netherlands',
      'de_de': 'Niederlande',
    } +
    {
      'en_us': 'Japan',
      'de_de': 'Japan',
    } +
    {
      'en_us': 'Spain',
      'de_de': 'Spanien',
    } +
    {
      'en_us': 'U.S.A.',
      'de_de': 'U.S.A.',
    } +
    {
      'en_us': 'United States of America',
      'de_de': 'U.S.A.',
    };
