// Copyright 2020 Hajo.Lemcke@gmail.com
// Please see the LICENSE file for details.

/// Provides input widgets (fields) for data manipulation
/// and a form which collects this fields.
/// The form provides common attributes to all fields
/// and allows enable(), reset(), save() and validate() all fields at once.
///
/// An input widget is used to change the value of a variable by some user interaction.
/// This library provides input widgets for all types of variables:
/// bool, int, double, String and DateTime.
/// The variable can be a single value or a value in a map.
/// The map can even be nested.
/// Its value is accessed by a 'path' string.
///
/// All input widgets share a common set of parameters which makes them easier to use.
/// This common set of parameters can be found at [InputField].
///
/// ## Input Utilities
///
/// Form and some input widgets rely on utility methods which can be used anywhere:
/// * [InputUtils.convertToType] converts a value to a type
/// * [InputUtils.readJson] reads a value from a nested map
/// * [InputUtils.writeJson] writes a value into a nested map of String value pairs
///
/// [DateHelperExtension] provides extensions for `DateTime` objects:
/// * [DateHelperExtension.isSameDay] compares only the date not the time
/// * [DateHelperExtension.julianDay] computes the Julian Day
/// * [DateHelperExtension.weekOfYear] gets the week of year \[1..53\]
///
/// ## Architecture
///
/// This library is based on the following design criteria:
/// 1. Provide an easy to understand library for data manipulation
/// which is easy to use, to maintain and to extend.
/// 1. All input widgets share a common set of parameters (see [InputField]).
/// 1. Input widgets can be used standalone but will automatically attach
/// to any [InputForm] ancestor.
/// 1. The [InputForm] provides central handling of the common parameter which
/// will be used by all child fields but can be overwritten there.
/// 1. The [InputForm] provides methods to [enable()] , [reset()],
/// [save()] or [validate()] all input widgets from one central place.
/// 1. The value of an input widget is either given by `initialValue` and
/// written through `save()` or it is taken from and written to a `map`.
/// 1. The map can be centrally supplied to the form or individually at
/// each input widget
/// 1. Using the map or the initial value can be shared. Even both can be used
/// together.
/// 1. Input widgets inherit as much decoration from the form as possible
///  while this can still be overwritten at the input widget.
/// 1. Each input widget accepts a list of reusable validators by parameter
/// [InputField.validators] like 'NotNull', 'Min', 'Max', 'Future', 'Past', ...
/// 1. Input widgets do not have parameters for type conversion.
/// If this is required in some case, just use your converter on parameters
/// `initialValue` and `onSave`. Maybe this still requires further analysis.
/// 1. All input widgets should have an ".adaptive" constructor
/// allowing them to be used by Android and iOS. (Not implemented yet)
library flutter_input;

export 'src/date_helper.dart';
export 'src/input_checkbox.dart';
export 'src/input_country.dart';
export 'src/input_date.dart';
export 'src/input_datepicker.dart';
export 'src/input_datetime.dart';
export 'src/input_dropdown.dart';
export 'src/input_favorite.dart';
export 'src/input_form.dart';
export 'src/input_keyboard.dart';
export 'src/input_language.dart';
export 'src/input_password.dart';
export 'src/input_radio.dart';
export 'src/input_rating.dart';
export 'src/input_slider.dart';
export 'src/input_spinner.dart';
export 'src/input_switch.dart';
export 'src/input_text.dart';
export 'src/input_utils.dart';
export 'src/input_validators.dart';
