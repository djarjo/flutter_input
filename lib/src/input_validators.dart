// Copyright 2020 Hajo.Lemcke@mail.com
// Please see the LICENSE file for details.

/// Contains standard validators which can be attached to an input field
/// with `validators: [ InputValidator.NotNull, InputValidator.Min(6) ],`
///
/// Each validator returns `null` if there is no error.
/// Otherwise it returns an error message.
///

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

/// Checks the field value against the given maximum.
/// A string must have at least `maxVal` characters.
/// An int or double must be `<= maxVal`.
String Max(
  dynamic fieldValue,
  int maxVal, {
  String message,
}) {
  if (fieldValue == null) {
    return null;
  }
  if (fieldValue <= maxVal) {
    return null;
  }
  return message ?? 'Please enter a value smaller or equal to $maxVal';
}

/// Checks the length of the string against the given maximum.
/// A string must not have more than `maxVal` characters.
String MaxLength(
  String fieldValue,
  int maxLen, {
  String message,
}) {
  if (fieldValue == null) {
    return null;
  }
  if (fieldValue.length <= maxLen) {
    return null;
  }
  return message ?? 'Please enter not more than $maxLen characters';
}

/// Checks the field value against the given minimum.
/// An int or double must be `>= minVal`.
String Min(
  dynamic fieldValue,
  int minVal, {
  String message,
}) {
  if (fieldValue == null) {
    return null;
  }
  if (fieldValue >= minVal) {
    return null;
  }
  return message ?? 'Please enter a value greater or equal to $minVal';
}

/// Checks the length of the string against the given minimum.
/// A string must have at least `minLen` characters.
String MinLength(
  String fieldValue,
  int minLen, {
  String message,
}) {
  if (fieldValue == null) {
    return null;
  }
  if (fieldValue.length >= minLen) {
    return null;
  }
  return message ?? 'Please enter at least $minLen characters';
}
