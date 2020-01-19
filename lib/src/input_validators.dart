// Copyright 2020 Hajo.Lemcke@mail.com
// Please see the LICENSE file for details.

/// Contains standard validators which can be attached to an input field.
///
/// ```dart
/// validators: [ (v) => NotNull(v), (v) => Min(v, 6, message: 'Must be at least 6' ) ],
/// ```
///
/// Each validator returns `null` if there is no error.
/// Otherwise it returns an error message which can be individually set with
/// parameter [message].
///

/// Validates that [fieldValue] (DateTime) is after [checkValue].
///
/// Returns `null` if [fieldValue] > [checkValue] else an error message
String After(
  DateTime fieldValue,
  DateTime checkValue, {
  String message,
}) {
  assert(checkValue != null);
  if ((fieldValue == null) || (fieldValue.isAfter(checkValue))) {
    return null;
  }
  return message ?? 'Please enter a value in the future of $checkValue';
}

/// Validates that [fieldValue] (DateTime) is before [checkValue].
///
/// Returns `null` if [fieldValue] < [checkValue] else an error message
String Before(
  DateTime fieldValue,
  DateTime checkValue, {
  String message,
}) {
  if ((fieldValue == null) || (fieldValue.isBefore(checkValue))) {
    return null;
  }
  return message ?? 'Please enter a value in the past of $checkValue';
}

/// Validates that [fieldValue] (DateTime) is in the future.
///
/// Returns `null` if [fieldValue] > [DateTime.now()] else an error message
String Future(
  DateTime fieldValue, {
  String message,
}) {
  if ((fieldValue == null) || (fieldValue.isAfter(DateTime.now()))) {
    return null;
  }
  return message ?? 'Please enter a value in the future';
}

/// Validates that [fieldValue] (int or double) is equal to or smaller than [maxVal].
///
/// Returns `null` if [fieldValue] <= [maxVal] else an error message
String Max(
  num fieldValue,
  int maxVal, {
  String message,
}) {
  if ((fieldValue == null) || (fieldValue <= maxVal)) {
    return null;
  }
  return message ?? 'Please enter a value smaller or equal to $maxVal';
}

/// Validates that the string [fieldValue] is not longer than [maxLen].
///
/// Returns `null` if [fieldValue.length()] <= [maxLen] else an error message
String MaxLength(
  String fieldValue,
  int maxLen, {
  String message,
}) {
  if ((fieldValue == null) || (fieldValue.length <= maxLen)) {
    return null;
  }
  return message ?? 'Please enter not more than $maxLen characters';
}

/// Validates that [fieldValue] (int or double) is equal to or larger than [minVal].
///
/// Returns `null` if [fieldValue] >= [minVal] else an error message
String Min(
  num fieldValue,
  int minVal, {
  String message,
}) {
  if ((fieldValue == null) || (fieldValue >= minVal)) {
    return null;
  }
  return message ?? 'Please enter a value greater or equal to $minVal';
}

/// Validates that the string [fieldValue] is not shorter than [minLen].
///
/// Returns `null` if [fieldValue.length()] >= [minLen] else an error message
String MinLength(
  String fieldValue,
  int minLen, {
  String message,
}) {
  if ((fieldValue == null) || (fieldValue.length >= minLen)) {
    return null;
  }
  return message ?? 'Please enter at least $minLen characters';
}

/// Checks if the given value is not null.
String NotNull(
  dynamic fieldValue, {
  String message,
}) {
  if (fieldValue != null) {
    return null;
  }
  return message ?? 'Please enter a value';
}

/// Validates that [fieldValue] (DateTime) is in the past.
///
/// Returns `null` if [fieldValue] < [DateTime.now()] else an error message
String Past(
  DateTime fieldValue, {
  String message,
}) {
  if ((fieldValue == null) || (fieldValue.isBefore(DateTime.now()))) {
    return null;
  }
  return message ?? 'The value must be in the past';
}
