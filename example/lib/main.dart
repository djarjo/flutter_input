// Copyright 2020 Hajo.Lemcke@gmail.com
// Please see the LICENSE file for details.

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:intl/intl.dart';

import 'sample_form_page.dart';

/// Sample map with nested values
Map<String, dynamic> centralData = {
  'id': 666,
  'author': true,
  'amount': 123.45,
  'birthday': '1977-02-17',
  'name': 'Isaac Asimov',
  'rateCount': 4711,
  'rateValue': 71,
  // Nested map. Access with dotted path
  'myRating': {
    'favorite': true, // path = 'myRating.favorite'
    'value': 87, // path = 'myRating.value'
  },
};

/// Sample map used without [InputForm]
Map<String, dynamic> sampleSettings = {};

void main() {
  debugPaintSizeEnabled = false; // true does not work in web
  //--- Only prints info to console
  I18n.observeLocale = ({Locale oldLocale, Locale newLocale}) {
    print('I18n -> Locale changed from $oldLocale to $newLocale');
  };
  runApp(I18n(child: MyApp()));
}

/// Flutter code sample for package `flutter_input`
///
/// This app shows all input widgets provided in this package.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter_input',
      home: SampleFormPage(),
      localeResolutionCallback: (deviceLocale, supportedLocs) {
        print('localeResolutionCallback( $deviceLocale, $supportedLocs)');
        return MyAppLocale.setThisAppsLocale(context, deviceLocale);
      },
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: MyAppLocale.supportedLocales,
    );
  }
}

class MyAppLocale {
  /// Supported locales. 0 is default.
  static List<Locale> supportedLocales = [
    Locale('en', 'US'),
    Locale('de', 'DE'),
  ];
  static Locale _thisAppsLocale;

  /// Gets current locale. `null` means using device locale
  static Locale getThisAppsLocale() => _thisAppsLocale;

  /// Sets locale used by this app. If [newLocale] is not in list
  /// of [supportedLocales] then first entry from [supportedLocales] will be used.
  ///
  /// @return locale set for this app
  static Locale setThisAppsLocale(BuildContext context, Locale newLocale) {
    if ((newLocale != null) &&
        (supportedLocales.contains(newLocale) == false)) {
      newLocale = supportedLocales[0];
    }
    print('setThisAppsLocale I18n locale=${I18n.locale}');
    if (newLocale != _thisAppsLocale) {
      Locale oldLocale = _thisAppsLocale;
      _thisAppsLocale = newLocale;
      if (_thisAppsLocale == null) {
        Intl.defaultLocale = null;
        I18n.of(context).locale = null;
      } else {
        Intl.defaultLocale = _thisAppsLocale.toString();
        I18n.of(context).locale = Locale(_thisAppsLocale.languageCode);
      }
      print('Locale changed from $oldLocale to $_thisAppsLocale');
      return _thisAppsLocale;
    }
  }
}
