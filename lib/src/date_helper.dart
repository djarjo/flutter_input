/// Enumeration about which part of a [DateTime] object is used. A value of 'null'
/// is treated same as [dateAndTime]. Should be part of [DateTime] class.
enum DateTimeUsing {
  dateOnly,
  timeOnly,
  dateAndTime,
}

/// Extensions on DateTime.
/// * [dayOfYear()]
/// * [daysInMonth()]
/// * [isBetween()]
/// * [isInLeapYear()]
/// * [isOnSameDayAs()]
/// * [julianDay()]
/// * [weekOfYear()]
extension DateHelperExtension on DateTime {
  /// Returns the number of days in this year e.g.: February 1st = 32.
  int dayOfYear() {
    List<int> _daysInYear = <int>[
      0,
      0,
      31,
      59,
      90,
      120,
      151,
      181,
      212,
      243,
      273,
      304,
      334
    ];
    int doy = _daysInYear[month] + day;
    if (isInLeapYear() && (month > 2)) {
      doy++;
    }
    return doy;
  }

  /// Returns the number of days in the month.
  int daysInMonth() {
    if (isInLeapYear() && (month == 2)) {
      return 29;
    }
    List<int> _daysPerMonth = <int>[
      0,
      31,
      28,
      31,
      30,
      31,
      30,
      31,
      31,
      30,
      31,
      30,
      31
    ];
    return _daysPerMonth[month];
  }

  /// Returns `true` if this DateTime value is not older than `lower` (or `lower=null`)
  /// and not younger than `upper` (or `upper=null`).
  bool isBetween(DateTime lower, DateTime upper) {
    if ((lower != null) && (isBefore(lower))) return false;
    if ((upper != null) && (isAfter(upper))) return false;
    return true;
  }

  /// Returns `true` if this DateTime object is in a leap year with 366 days.
  bool isInLeapYear() {
    if ((year % 400) == 0) return true;
    if (((year % 4) == 0) && ((year % 100) != 0)) return true;
    return false;
  }

  /// Returns `true` if this DateTime object is on the same day as `another`.
  bool isOnSameDayAs(DateTime another) {
    if (another == null) {
      return false;
    }
    if (year != another.year || month != another.month || day != another.day) {
      return false;
    }
    return true;
  }

  /// Computes the Julian day which is the number of days since Monday, January 1, 4713 BC.
  int julianDay() {
    int a = ((14 - month) ~/ 12);
    int y = year + 4800 - a;
    int m = month + (12 * a) - 3;
    int jd = (day + (((153 * m) + 2) ~/ 5) + (365 * y) + (y ~/ 4));

    // --- Correction for dates since 1582-10-15 <=> Gregorian Calendar
    if (year > 1582 ||
        (year == 1582 && (month > 10 || (month == 10 && day >= 15)))) {
      jd = (jd - (y ~/ 100) + (y ~/ 400) - 32045);
    } else {
      jd = jd - 32083;
    }
    return jd;
  }

  /// Week number in year. Week 1 has the first Thursday.
  int weekOfYear() {
    assert((1 <= month) && (month <= 12));
    assert((1 <= day) && (day <= 31));
    int woy = (dayOfYear() + 10 - weekday) ~/ 7;
    if (woy < 1) {
      return DateTime(year - 1, 12, 31).weekOfYear();
    }
    if (woy == 53) {
      if (DateTime(year + 1, 1, 1).weekday <= 4) {
        return 1;
      }
    }
    return woy;
  }
}

/// Enumeration of formats for dates and times.
enum DateTimeFormat {
  /// Date format '24.12.2001'
  ///
  /// using: [dateOnly]
  dd_dot_MM_dot_yyyy,

  /// Corresponds to the ICU 'HH:mm' pattern.
  ///
  /// This format uses 24-hour two-digit zero-padded hours. Controls are always
  /// laid out horizontally. Hours are separated from minutes by one colon
  /// character.
  ///
  /// using: [timeOnly]
  HH_colon_mm,

  /// Corresponds to ISO 8601 'yyyy-MM-dd HH:mm' pattern
  ///
  /// using: [dateAndTime]
  ISO,

  /// US format '12/24/2001'
  ///
  /// using: [dateOnly]
  MM_slash_dd_slash_yyyy,

  /// ISO date format 2001-12-24
  ///
  /// using: [dateOnly]
  yyyy_dash_MM_dash_dd,
}

/// Provides static methods for date computations which are not available in Dart 2.7.0.
///
/// Values are according to ISO 8601 as in [DateTime]:
/// * January = 1, ..., December = 12,
/// * Monday = 1, ..., Sunday = 7
class DateHelper {
  /// Gets the default pattern for date, time or date with time.
  static String getDefaultPattern(DateTimeUsing using) {
    if (using == null || using == DateTimeUsing.dateAndTime) {
      return DateTimeFormat.ISO.toString();
    }
    if (using == DateTimeUsing.dateOnly) {
      return DateTimeFormat.yyyy_dash_MM_dash_dd.toString();
    }
    return DateTimeFormat.HH_colon_mm.toString();
  }

  /// Returns `true` if `year` and `month` is not older than `lower` (or `lower=null`)
  /// and not younger than `upper` (or `upper=null`).
  static bool isBetween({int year, int month, DateTime lower, DateTime upper}) {
    if ((lower != null) &&
        ((year < lower.year) || (year == lower.year && month < lower.month)))
      return false;
    if ((upper != null) &&
        ((year > upper.year) || (year == upper.year && month > upper.month)))
      return false;
    return true;
  }

  static DateTimeUsing isUsing(DateTimeFormat format) {
    if (format == null) {
      return DateTimeUsing.dateAndTime;
    }
    switch (format) {
      case DateTimeFormat.dd_dot_MM_dot_yyyy:
        return DateTimeUsing.dateOnly;
      case DateTimeFormat.HH_colon_mm:
        return DateTimeUsing.timeOnly;
      case DateTimeFormat.ISO:
        return DateTimeUsing.dateOnly;
      case DateTimeFormat.MM_slash_dd_slash_yyyy:
        return DateTimeUsing.dateOnly;
      case DateTimeFormat.yyyy_dash_MM_dash_dd:
        return DateTimeUsing.dateOnly;
    }
    return DateTimeUsing.dateAndTime;
  }
}
