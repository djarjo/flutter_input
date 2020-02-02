// Copyright 2020 Hajo.Lemcke@gmail.com
// Please see the LICENSE file for details.

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_input/flutter_input.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:i18n_extension/i18n_widget.dart';

import 'form_page.dart';
import 'main.i18n.dart';

/// Sample map with nested values
Map<String, dynamic> sampleData = {
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

/// Drawer sample usable in all pages
Drawer buildDrawer(BuildContext context) {
  _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
  return Drawer(
    child: ListView(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.language),
          title: InputLanguage(
            initialValue: state.thisAppsLocale,
            onChanged: (v) => state.setState(() {
              I18n.of(context).locale = v;
            }),
            supportedLocales: supportedLocales,
          ),
        ),
        AboutListTile(
          icon: Icon(Icons.info),
          applicationLegalese: 'Free to Use',
          applicationName: 'flutter_input',
          applicationVersion: 'v1.1.0',
          aboutBoxChildren: <Widget>[
            Text('Thanks for using flutter_input!'.i18n),
          ],
        ),
      ],
    ),
  );
}

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

  /// Called from anywhere in the application to change apps locale
  static bool setThisAppsLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    if (state.thisAppsLocale == newLocale) {
      return false;
    }
    state.setState(() {
      print('${state.thisAppsLocale} -> $newLocale');
      state.thisAppsLocale = newLocale;
    });
    return true;
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
//      print('Changing from $oldLocale to $newLocale.');
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
