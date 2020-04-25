// Copyright 2020 Hajo.Lemcke@gmail.com
// Please see the LICENSE file for details.

import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  String get i18n => localize(this, _t);
}

final _t = Translations('en_us') +
    {
      'en_us': 'MM/DD/YYYY',
      'de_de': 'YYYY-MM-DD',
    } +
    // --- Days in week - long
    {
      'en_us': 'Monday',
      'de_de': 'Montag',
    } +
    {
      'en_us': 'Tuesday',
      'de_de': 'Dienstag',
    } +
    {
      'en_us': 'Wednesday',
      'de_de': 'Mittwoch',
    } +
    {
      'en_us': 'Thursday',
      'de_de': 'Donnerstag',
    } +
    {
      'en_us': 'Friday',
      'de_de': 'Freitag',
    } +
    {
      'en_us': 'Saturday',
      'de_de': 'Samstag',
    } +
    {
      'en_us': 'Sunday',
      'de_de': 'Sonntag',
    } +
    // --- Days in week - short
    {
      'en_us': 'Mo',
      'de_de': 'Mo',
    } +
    {
      'en_us': 'Tu',
      'de_de': 'Di',
    } +
    {
      'en_us': 'We',
      'de_de': 'Mi',
    } +
    {
      'en_us': 'Th',
      'de_de': 'Do',
    } +
    {
      'en_us': 'Fr',
      'de_de': 'Fr',
    } +
    {
      'en_us': 'Sa',
      'de_de': 'Sa',
    } +
    {
      'en_us': 'Su',
      'de_de': 'So',
    } +
    // --- Months in year - long
    {
      'en_us': 'January',
      'de_de': 'Januar',
    } +
    {
      'en_us': 'February',
      'de_de': 'Februar',
    } +
    {
      'en_us': 'March',
      'de_de': 'März',
    } +
    {
      'en_us': 'April',
      'de_de': 'April',
    } +
    {
      'en_us': 'May',
      'de_de': 'Mai',
    } +
    {
      'en_us': 'June',
      'de_de': 'Juni',
    } +
    {
      'en_us': 'July',
      'de_de': 'Juli',
    } +
    {
      'en_us': 'August',
      'de_de': 'August',
    } +
    {
      'en_us': 'September',
      'de_de': 'September',
    } +
    {
      'en_us': 'October',
      'de_de': 'Oktober',
    } +
    {
      'en_us': 'November',
      'de_de': 'November',
    } +
    {
      'en_us': 'December',
      'de_de': 'Dezember',
    } +
    // --- Months in year - short
    {
      'en_us': 'Jan',
      'de_de': 'Jan',
    } +
    {
      'en_us': 'Feb',
      'de_de': 'Feb',
    } +
    {
      'en_us': 'Mar',
      'de_de': 'Mär',
    } +
    {
      'en_us': 'Apr',
      'de_de': 'Apr',
    } +
    {
      'en_us': 'May',
      'de_de': 'Mai',
    } +
    {
      'en_us': 'Jun',
      'de_de': 'Jun',
    } +
    {
      'en_us': 'Jul',
      'de_de': 'Jul',
    } +
    {
      'en_us': 'Aug',
      'de_de': 'Aug',
    } +
    {
      'en_us': 'Sep',
      'de_de': 'Sep',
    } +
    {
      'en_us': 'Oct',
      'de_de': 'Okt',
    } +
    {
      'en_us': 'Nov',
      'de_de': 'Nov',
    } +
    {
      'en_us': 'Dec',
      'de_de': 'Dez',
    };
