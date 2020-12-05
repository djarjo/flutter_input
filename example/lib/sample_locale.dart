import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:intl/intl.dart';

/// This class groups locale specific functionality.
class SampleLocale {
  /// Supported locales. 0 is default.
  static final List<Locale> supportedLocales = [
    Locale('en', 'US'),
    Locale('de', 'DE'),
  ];
  Locale _thisAppsLocale;

  /// Device locales as selected and ordered by user.
  List<Locale> _deviceLocales;

  /// Prevent setting locale in I18n during a build phase
  bool _preventSetI18n = true;

  /// Make it a singleton
  static final SampleLocale _instance = SampleLocale._privateConstructor();

  /// Constructor sets locale from Window class.
  factory SampleLocale() {
    return _instance;
  }

  SampleLocale._privateConstructor() {
//    Window _window = WidgetsBinding.instance.window;
    _deviceLocales = window.locales;
    _thisAppsLocale =
        resolveLocale(window.locale, window.locales, supportedLocales);
    Intl.defaultLocale = _thisAppsLocale.toString();
    print('DjarjoLocale() -> ${_thisAppsLocale}, deviceLocales='
        '${_deviceLocales}, supportedLocales=$supportedLocales');
  }

  /// Gets current locale.
  Locale getThisAppsLocale() => _thisAppsLocale;

  /// Callback method for [MaterialApp.localeListResolutionCallback].
  ///
  /// This method is called once at startup and later when the user has
  /// changed the list of his preferred languages in the device.
  ///
  /// Parameter [devLocales] is not used because it changes quite strange
  /// over multiple calls!
  /// TODO follow up and retest newer Flutter versions > 1.22.4
  Locale localeListResolutionMethod(
      BuildContext context, List<Locale> devLocales, List<Locale> appLocales) {
    print('localeListResolutionMethod( $devLocales, $appLocales)'
        ' // _preventSetI18n=$_preventSetI18n  // current locale = $_thisAppsLocale');
    // _deviceLocales = devLocales; // Not working in Flutter 1.22.4
    _deviceLocales = window.locales; // Updates user preferred list
    if (_preventSetI18n) {
      _preventSetI18n = false;
      // WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>
      //   localeListResolutionMethod(context, deviceLocales, appLocales));
    } else {
      _setThisAppsLocale(context, devLocales[0]); // resolve locale to use
    }
    return _thisAppsLocale;
  }

  /// Resolves locale from [appLocales].
  /// If [newLocale] exists in [appLocales] then it will be returned.
  /// If it does not exist then a match is tried by comparing language codes.
  /// If no match found then [deviceLocales] will be checked in order.
  /// If there is a full match with [appLocales] then it will be returned.
  /// If there is no match then language codes will be compared.
  /// If still no match is found then the first entry from [appLocales]
  /// will be returned.
  ///
  /// Supply `null` for [newLocale] to use device locales.
  Locale resolveLocale(
      Locale newLocale, List<Locale> devLocales, List<Locale> appLocales) {
    String langCode;
    print('resolveLocale( $newLocale, $devLocales, $appLocales )  //  '
        'devLocales=$_deviceLocales, appLocales=$supportedLocales  // '
        'current locale = $_thisAppsLocale');
    if (appLocales.contains(newLocale)) {
      return newLocale;
    }
    //--- No full match => try language codes only
    if (newLocale != null) {
      langCode = newLocale.languageCode;
      for (Locale appLoc in appLocales) {
        if (langCode == appLoc.languageCode) {
          return appLoc;
        }
      }
    }
    //--- No match => use first full match from device locales
    for (Locale devLoc in devLocales) {
      if (appLocales.contains(devLoc)) {
        return devLoc;
      }
    }
    //--- No full match => try language codes only
    for (Locale devLoc in devLocales) {
      langCode = devLoc.languageCode;
      for (Locale appLoc in appLocales) {
        if (langCode == appLoc.languageCode) {
          return appLoc;
        }
      }
    }
    //--- Use default from app locales
    return supportedLocales[0];
  }

  /// Sets locale by first resolving to a supported locale.
  ///
  /// @return locale set for this app
  Locale setThisAppsLocale(BuildContext context, Locale newLocale) {
    _setThisAppsLocale(context, newLocale);
    _preventSetI18n = true;
    return _thisAppsLocale;
  }

  Locale _setThisAppsLocale(BuildContext context, Locale newLocale) {
    Locale localeToSet =
        resolveLocale(newLocale, _deviceLocales, supportedLocales);
    print('_setThisAppsLocale( $newLocale ) resolves to $localeToSet // '
        'current locale = $_thisAppsLocale');
    if (localeToSet != _thisAppsLocale) {
      Locale oldLocale = _thisAppsLocale;
      _thisAppsLocale = localeToSet;
      Intl.defaultLocale = _thisAppsLocale.toString();
      print('Locale changed from $oldLocale to $_thisAppsLocale -> '
          'calling I18n');
      I18n.of(context).locale = Locale(_thisAppsLocale.languageCode);
//      notifyListeners(); // I18n calls setState() !!!
    }
    return _thisAppsLocale;
  }
}
