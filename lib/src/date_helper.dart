/// Enumeration about which part of a [DateTime] object is used. A value of 'null'
/// is treated same as [dateAndTime]. Should be part of [DateTime] class.
enum DateTimeUsing {
  dateOnly,
  timeOnly,
  dateAndTime,
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
  /// Days in each month (January = 1)
  static List<int> daysPerMonth = <int>[
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

  static int computeDaysInMonth(int year, int month) {
    if (isLeapYear(year) && (month == 2)) {
      return 29;
    }
    return daysPerMonth[month];
  }

  /// Computes the Julian day which is the number of days since Monday, January 1, 4713 BC.
  ///
  /// The date is given by year, [month] 1..12 and [day] 1..31.
  static int computeJulianDay(int year, int month, int day) {
    int a = ((14 - month) ~/ 12);
    int y = year + 4800 - a;
    int m = month + (12 * a) - 3;
    int jd = (day + (((153 * m) + 2) ~/ 5) + (365 * y) + (y ~/ 4));

    // --- Dates since 1582-10-15 <=> Gregorian Calendar
    if (year > 1582 ||
        (year == 1582 && (month > 10 || (month == 10 && day >= 15)))) {
      jd = (jd - (y ~/ 100) + (y ~/ 400) - 32045);
    } else {
      jd = jd - 32083;
    }
    return jd;
  }

  /// Computes the day of the week with 1=Monday until 7=Sunday
  static int computeWeekday(int year, int month, int day) {
    int jd = computeJulianDay(year, month, day);
    return (jd % 7) + 1;
  }

  /// Computes the week of the year.
  ///
  /// ISO-8601 specifies the first week of the year must contain at least 4 days.
  /// Otherwise the days still belong to the last week of the previous year.
  static int computeWeekOfYear(int year, int month, int day) {
    int jd = computeJulianDay(year, month, day);

    // --- Get first day of that year
    int jdfirst = computeJulianDay(year, 1, 1);
    int days = jd - jdfirst;

    // --- Which day is it (0 = Monday)
    int weekday = jdfirst % 7;

    // --- Compute weeks
    int calWeek =
        ((days ~/ 7) + ((10 - weekday) ~/ 7) + (((days % 7) + weekday) ~/ 7));
    if (calWeek == 0) {
      calWeek = computeWeekOfYear(year - 1, 12, 31);
    }
    return calWeek;
  }

  static int getDaysInMonth(DateTime date) {
    return computeDaysInMonth(date.year, date.month);
  }

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

  /// Gets the Julian day which is the number of days since Monday, January 1,
  /// 4713 BC.
  static int getJulianDay(DateTime date) {
    return computeJulianDay(date.year, date.month, date.day);
  }

  /// See [computeWeekOfYear()]
  static int getWeekOfYear(DateTime date) {
    return computeWeekOfYear(date.year, date.month, date.day);
  }

  /// Checks if both dates are on the same calendar day.
  ///
  /// Should be a method in [DateTime] `isOnSameDayAs( DateTime another )`
  static bool isSameDay(DateTime one, DateTime two) {
    if (one == null || two == null) {
      return false;
    }
    if (one.year != two.year || one.month != two.month || one.day != two.day) {
      return false;
    }
    return true;
  }

  /// Checks if either [date] or [year] with [month] is within [first] and [last].
  ///
  /// If [first] or [last] is `null` then any value in that directions returns `true`.
  static bool isBetween({
    DateTime first,
    DateTime last,
    DateTime date,
    int year,
    int month,
  }) {
    if (first != null) {
      if (date != null) {
        // date given
        if (date.isBefore(first)) {
          return false;
        }
      } else {
        // year and month given
        if ((date.year < year) || (date.year == year && date.month < month)) {
          return false;
        }
      }
    }
    if (last != null) {
      if (date != null) {
        // date given
        if (date.isAfter(last)) {
          return false;
        }
      } else {
        // year and month given
        if ((date.year > year) || (date.year == year && date.month > month)) {
          return false;
        }
      }
    }
    return true;
  }

  /// Checks if the given year is a leap year which has 366 days instead of 365.
  static bool isLeapYear(int year) {
    if ((year % 400) == 0) return true;
    if (((year % 4) == 0) && ((year % 100) != 0)) return true;
    return false;
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
