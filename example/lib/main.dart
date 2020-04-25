// Copyright 2020 Hajo.Lemcke@gmail.com
// Please see the LICENSE file for details.

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:i18n_extension/i18n_widget.dart';

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

/// Supported locales. 0 is default.
List<Locale> supportedLocales = [
  Locale('en', 'US'),
  Locale('de', 'DE'),
];

void main() {
  debugPaintSizeEnabled = false; // true does not work in web
  runApp(MyApp());
}

/// Flutter code sample for package `flutter_input`
///
/// This app shows all input widgets provided in this package.
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();

  static Locale getThisAppsLocale(BuildContext context) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    return state.thisAppsLocale;
  }

  /// Called from anywhere in the application to change apps locale
  static void setThisAppsLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    if (state.thisAppsLocale != newLocale) {
      print('${state.thisAppsLocale} -> $newLocale');
      // ignore: invalid_use_of_protected_member
      state.setState(() {
        state.thisAppsLocale = newLocale;
      });
    }
  }
}

class _MyAppState extends State<MyApp> {
  /// The locale used by the whole app
  Locale thisAppsLocale;

  @override
  void initState() {
    thisAppsLocale ??= WidgetsBinding.instance.window.locale;
    super.initState();
    I18n.observeLocale = ({Locale oldLocale, Locale newLocale}) {
      print('Changing from $oldLocale to $newLocale.');
      if (thisAppsLocale != newLocale) {
        setState(() {
          thisAppsLocale = newLocale;
        });
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    return I18n(
      initialLocale: thisAppsLocale,
      child: MaterialApp(
        title: 'flutter_input',
        home: SampleFormPage(),
        locale: thisAppsLocale,
/*        localeResolutionCallback: (deviceLocale, supportedLocales) {
          if (thisAppsLocale != deviceLocale) {
            print('thisA=$thisAppsLocale, devLoc=$deviceLocale');
            thisAppsLocale = deviceLocale;
          }
          return thisAppsLocale;
        },
  */
        localizationsDelegates: [
          // ... app-specific localization delegate[s] here
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: supportedLocales,
      ),
    );
  }
}
