// Copyright 2020 Hajo.Lemcke@gmail.com
// Please see the LICENSE file for details.

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:i18n_extension/i18n_widget.dart';

import 'sample_form_page.dart';
import 'sample_locale.dart';

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
  runApp(MyApp());
}

/// Flutter code sample for package `flutter_input`
///
/// This app shows all input widgets provided in this package.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return I18n(
      initialLocale: Locale(SampleLocale().getThisAppsLocale().languageCode),
      child: Builder(builder: (BuildContext ctx2) {
        return MaterialApp(
          title: 'flutter_input',
          home: SampleFormPage(),
          localeResolutionCallback: (deviceLocale, supportedLocs) {
            return SampleLocale().setThisAppsLocale(ctx2, deviceLocale);
          },
          locale: SampleLocale().getThisAppsLocale(),
          localizationsDelegates: [
            // ... app-specific localization delegate[s] here
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: SampleLocale.supportedLocales,
        );
      }),
    );
  }
}
