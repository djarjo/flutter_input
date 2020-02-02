// Copyright 2020 Hajo.Lemcke@gmail.com
// Please see the LICENSE file for details.

import 'country.i18n.dart';

extension CountryExtension on Country {
  String getLocalizedName() {
    return name.i18n;
  }
}

/// Country data according to ISO-3166.
///
/// Use `code2` to get the flag image:
/// ```
/// Image.asset(
/// 'assets/packages/flutter_input/' + country.code2 + '.png',
/// package: 'flutter_input',
/// );
/// ```
///
/// Use `code2` and `language` to build the Locale:
/// ```
/// Locale locale = Locale( country.language, country.code2 );
/// ```
///
/// TODO Complete this list. Any help is highly appreciated :-)
class Country {
  Country(
      {this.code2,
      this.code3,
      this.language,
      this.name,
      this.predial,
      this.tld});

  /// ISO-3166 Alpha-2 code
  final String code2;

  /// ISO-3166 Alpha-3 code
  final String code3;

  /// Primary official language.
  ///
  /// ISO-639-1 two letter lowercase code as used for `Locale`.
  final String language;

  /// ISO-3166 Name in standard locale en_US
  final String name;

  /// Top level domain
  final String tld;

  /// International phone predial code
  final int predial;

  /// Returns `null` if `code2 == null` or not found
  static Country findByCode2(String code2) {
    if (code2 == null) return null;
    code2 = code2.toUpperCase();
    if (code2.length != 2) return null;
    return _countries.firstWhere((country) => country.code2 == code2,
        orElse: () => null);
  }

  /// Returns `null` if `code3 == null` or not found
  static Country findByCode3(String code3) {
    if (code3 == null) return null;
    code3 = code3.toUpperCase();
    if (code3.length != 3) return null;
    return _countries.firstWhere((country) => country.code3 == code3,
        orElse: () => null);
  }

  /// Returns `null` if `number == null` or not found
  static Country findByPredial(int number) {
    if (number == null) return null;
    return _countries.firstWhere((country) => country.predial == number,
        orElse: () => null);
  }

  static List<Country> values() {
    return _countries;
  }

  static final List<Country> _countries = [
    Country(
      code2: 'AT',
      code3: 'AU',
      language: 'de',
      name: 'Austria',
      tld: 'at',
      predial: 43,
    ),
    Country(
      code2: 'AU',
      code3: 'AUS',
      language: 'en',
      name: 'Australia',
      tld: 'au',
      predial: 61,
    ),
    Country(
      code2: 'BE',
      code3: 'BEL',
      language: 'fr',
      name: 'Belgium',
      tld: 'be',
      predial: 32,
    ),
    Country(
      code2: 'BR',
      code3: 'BRA',
      language: 'es',
      name: 'Brazil',
      tld: 'br',
      predial: 55,
    ),
    Country(
      code2: 'CA',
      code3: 'CAN',
      language: 'en',
      name: 'Canada',
      tld: 'ca',
      predial: 1,
    ),
    Country(
      code2: 'CN',
      code3: 'CHN',
      language: 'ch',
      name: 'China',
      tld: 'cn',
      predial: 86,
    ),
    Country(
      code2: 'DE',
      code3: 'DEU',
      language: 'de',
      name: 'Germany',
      tld: 'de',
      predial: 49,
    ),
    Country(
      code2: 'FR',
      code3: 'FRA',
      language: 'fr',
      name: 'France',
      tld: 'fr',
      predial: 33,
    ),
    Country(
      code2: 'GB',
      code3: 'GBR',
      language: 'en',
      name: 'Great Britain',
      tld: 'uk',
      predial: 44,
    ),
    Country(
      code2: 'IN',
      code3: 'IND',
      language: 'hi',
      name: 'India',
      tld: 'in',
      predial: 91,
    ),
    Country(
      code2: 'IT',
      code3: 'ITA',
      language: 'it',
      name: 'Italy',
      tld: 'it',
      predial: 39,
    ),
    Country(
      code2: 'JP',
      code3: 'JPN',
      language: 'jp',
      name: 'Japan',
      tld: 'jp',
      predial: 81,
    ),
    Country(
      code2: 'NL',
      code3: 'NLD',
      language: 'nl',
      name: 'Netherlands',
      tld: 'nl',
      predial: 31,
    ),
    Country(
      code2: 'ES',
      code3: 'ESP',
      language: 'es',
      name: 'Spain',
      tld: 'es',
      predial: 34,
    ),
    Country(
      code2: 'US',
      code3: 'USA',
      language: 'en',
      name: 'United States of America',
      tld: 'us',
      predial: 1,
    ),
  ];
}
