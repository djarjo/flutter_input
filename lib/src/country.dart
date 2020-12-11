// Copyright 2020 Hajo.Lemcke@gmail.com
// Please see the LICENSE file for details.

import 'country.csv.dart';

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
class Country {
  static final List<Country> countries = [];

  /// Constructor initializes list of countries once.
  Country(
      {this.code2,
      this.code3,
      this.currency,
      this.language,
      this.name,
      this.predial,
      this.timezone,
      this.translations}) {
    _initialize();
  }

  /// ISO-3166 Alpha-2 code. 2 char uppercase
  final String code2;

  /// ISO-3166 Alpha-3 code. 3 char uppercase
  final String code3;

  /// Official currency. ISO-4217 currency code. 3 char uppercase
  final String currency;

  /// Official language. ISO-639-1 code. 2 char lowercase.
  final String language;

  /// ISO-3166 Name in standard locale en
  final String name;

  /// International phone predial code
  final int predial;

  /// Timezone of this country.
  /// Returns mean timezone if the country covers multiple lines of latitude.
  final double timezone;

  /// Country name by language code
  final Map<String, String> translations;

  /// Returns `null` if `code2 == null` or not found
  static Country findByCode2(String code2) {
    _initialize();
    if ((code2 == null) || (code2.length != 2)) return null;
    code2 = code2.toUpperCase();
    return countries.firstWhere((country) => country.code2 == code2,
        orElse: () => null);
  }

  /// Returns `null` if `code3 == null` or not found
  static Country findByCode3(String code3) {
    _initialize();
    if (code3 == null) return null;
    code3 = code3.toUpperCase();
    if (code3.length != 3) return null;
    return countries.firstWhere((country) => country.code3 == code3,
        orElse: () => null);
  }

  /// Returns `null` if `number == null` or not found
  static Country findByPredial(int number) {
    _initialize();
    if (number == null) return null;
    return countries.firstWhere((country) => country.predial == number,
        orElse: () => null);
  }

  /// Gets country name translated into given language.
  /// If no translation found then the english name will be returned.
  String getTranslation(String langCode) {
    if (langCode != 'en' && translations != null) {
      return translations[langCode] ?? name;
    }
    return name;
  }

  @override
  String toString() {
    return '$name ($code2)';
  }

  // Columns are: code2, code3, language, name, predial, codenum, timezone
  static bool _initializing = false, _initialized = false;
  static void _initialize() {
    if (_initialized || _initializing) {
      return;
    }
    _initializing = true;
    //--- Load country data
    List<String> languages = [];
    List<String> lines = csv_list_of_countries.split('\n');
    for (String line in lines) {
      if (line.isEmpty) {
        continue;
      }
      List<String> parts = line.split(',');
      if (parts[0] == 'alpha-2') {
        for (int i = 8; i < parts.length; i++) {
          languages.add(parts[i]);
        }
      } else {
        int _predial = (parts[6] == null) ? null : int.tryParse(parts[6]);
        double _timezone =
            (parts[7] == null) ? null : double.tryParse(parts[7]);
        Map<String, String> _t10ns = {};
        for (int i = 0; i < languages.length; i++) {
          if (parts[8 + i].isNotEmpty) {
            _t10ns[languages[i]] = parts[8 + i];
          }
        }
        countries.add(Country(
          code2: parts[0],
          code3: parts[1],
          name: parts[3],
          currency: parts[4],
          language: parts[5],
          predial: _predial,
          timezone: _timezone,
          translations: _t10ns,
        ));
      }
    }
    //--- Ready
    _initialized = true;
  }

  /// Gets iterable list of all countries
  static List<Country> values() {
    _initialize();
    return countries;
  }
}
