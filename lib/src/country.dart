// Copyright 2020 Hajo.Lemcke@gmail.com
// Please see the LICENSE file for details.

import 'package:i18n_extension/i18n_widget.dart';

import 'country.csv.dart';
import 'country.i18n.dart';

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
  Country() {
    _initialize();
  }

  /// ISO-3166 Alpha-2 code
  String code2;

  /// ISO-3166 Alpha-3 code
  String code3;

  /// Primary official language.
  ///
  /// ISO-639-1 two letter lowercase code as used for `Locale`.
  String language;

  /// Country name by language
  Map<String, String> _localizations;

  /// ISO-3166 Name in standard locale en_US
  String name;

  /// International phone predial code
  int predial;

  /// Timezone of this country.
  /// Returns the mean timezone if the country covers multiple lines of
  /// latitude.
  double timezone;

  /// Returns `null` if `code2 == null` or not found
  static Country findByCode2(String code2) {
    if ((code2 == null) || (code2.length != 2)) return null;
    code2 = code2.toUpperCase();
    return countries.firstWhere((country) => country.code2 == code2,
        orElse: () => null);
  }

  /// Returns `null` if `code3 == null` or not found
  static Country findByCode3(String code3) {
    if (code3 == null) return null;
    code3 = code3.toUpperCase();
    if (code3.length != 3) return null;
    return countries.firstWhere((country) => country.code3 == code3,
        orElse: () => null);
  }

  /// Returns `null` if `number == null` or not found
  static Country findByPredial(int number) {
    if (number == null) return null;
    return countries.firstWhere((country) => country.predial == number,
        orElse: () => null);
  }

  /// Gets localized country name. Current locale is taken from I18n.
  /// If no localized name found then the english name will be returned.
  String getLocalizedName() {
    String langCode = I18n.language;
    if (langCode != 'en' && _localizations != null) {
      return _localizations[langCode] ?? name;
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
    List<String> lines = csv_list_of_countries.split('\n');
    for (String line in lines) {
      Country country = Country();
      List<String> parts = line.split(',');
      country.code2 = parts[0];
      country.code3 = parts[1];
      country.language = parts[2];
      country.name = parts[3];
      country.predial = (parts[4] == null) ? null : int.tryParse(parts[4]);
      country.timezone = (parts[5] == null) ? null : double.tryParse(parts[5]);
      countries.add(country);
    }
    //--- Load translations of country names
    List<String> languageCode;
    List<String> translationLines = countryTranslations.split('\n');
    for (String line in translationLines) {
      if (line.isNotEmpty) {
        List<String> cols = line.split(',');
        //--- Extract language codes
        if (cols[0] == 'code2') {
          languageCode = cols;
        } else {
          Country country = findByCode2(cols[0]);
          country._localizations ??= {};
          for (int i = 1; i < languageCode.length; i++) {
            country._localizations[languageCode[i]] = cols[i];
          }
        }
      }
    }

    //--- Ready
    _initialized = true;
  }

  static List<Country> values() {
    _initialize();
    return countries;
  }
}
