// Copyright 2020 Hajo.Lemcke@gmail.com
// Please see the LICENSE file for details.

import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  String get i18n => localize(this, _t);

  static final _t = Translations('en') +
      {
        'en': 'MM/DD/YYYY',
        'de': 'YYYY-MM-DD',
      } +
      // --- Days in week - long
      {
        'en': 'Monday',
        'de': 'Montag',
      } +
      {
        'en': 'Tuesday',
        'de': 'Dienstag',
      } +
      {
        'en': 'Wednesday',
        'de': 'Mittwoch',
      } +
      {
        'en': 'Thursday',
        'de': 'Donnerstag',
      } +
      {
        'en': 'Friday',
        'de': 'Freitag',
      } +
      {
        'en': 'Saturday',
        'de': 'Samstag',
      } +
      {
        'en': 'Sunday',
        'de': 'Sonntag',
      } +
      // --- Days in week - short
      {
        'en': 'Mo',
        'de': 'Mo',
      } +
      {
        'en': 'Tu',
        'de': 'Di',
      } +
      {
        'en': 'We',
        'de': 'Mi',
      } +
      {
        'en': 'Th',
        'de': 'Do',
      } +
      {
        'en': 'Fr',
        'de': 'Fr',
      } +
      {
        'en': 'Sa',
        'de': 'Sa',
      } +
      {
        'en': 'Su',
        'de': 'So',
      } +
      // --- Months in year - long
      {
        'en': 'January',
        'de': 'Januar',
      } +
      {
        'en': 'February',
        'de': 'Februar',
      } +
      {
        'en': 'March',
        'de': 'März',
      } +
      {
        'en': 'April',
        'de': 'April',
      } +
      {
        'en': 'May',
        'de': 'Mai',
      } +
      {
        'en': 'June',
        'de': 'Juni',
      } +
      {
        'en': 'July',
        'de': 'Juli',
      } +
      {
        'en': 'August',
        'de': 'August',
      } +
      {
        'en': 'September',
        'de': 'September',
      } +
      {
        'en': 'October',
        'de': 'Oktober',
      } +
      {
        'en': 'November',
        'de': 'November',
      } +
      {
        'en': 'December',
        'de': 'Dezember',
      } +
      // --- Months in year - short
      {
        'en': 'Jan',
        'de': 'Jan',
      } +
      {
        'en': 'Feb',
        'de': 'Feb',
      } +
      {
        'en': 'Mar',
        'de': 'Mär',
      } +
      {
        'en': 'Apr',
        'de': 'Apr',
      } +
      {
        'en': 'May',
        'de': 'Mai',
      } +
      {
        'en': 'Jun',
        'de': 'Jun',
      } +
      {
        'en': 'Jul',
        'de': 'Jul',
      } +
      {
        'en': 'Aug',
        'de': 'Aug',
      } +
      {
        'en': 'Sep',
        'de': 'Sep',
      } +
      {
        'en': 'Oct',
        'de': 'Okt',
      } +
      {
        'en': 'Nov',
        'de': 'Nov',
      } +
      {
        'en': 'Dec',
        'de': 'Dez',
      };
}
