// Copyright 2020 Hajo.Lemcke@gmail.com
// Please see the LICENSE file for details.

/// Provides input widgets for data manipulation which can be used standalone or within a form.
///
/// An input widget is used to change the value of a variable through user interaction.
/// This library provides input widgets for all types of variables:
/// bool, int, double, String and DateTime.
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
/// 1. Provide an easy to understand library for data input which is easy to use, to maintain and to extend.
/// 1. All input widgets share a common set of parameters (see [InputField]).
/// 1. The [InputForm] provides a central data object.
///  [InputForm.value] is a `Map` which can be nested.
///  The form provides methods to [enable()] , [validate()] or [save()] the values from all input widgets.
/// 1. An input widget automatically attaches itself to the [InputForm] by its parameter [InputField.path].
///  This parameter is also used to obtain an initial value and to save back the widget value after editing.
/// 1. Any input widget can be used stand alone, even when it is a descendant of a form.
///  For this, [path] must be `null` and [onChanged] must not be `null`.
/// 1. Input widgets inherit as much decoration from the form as possible
///  while this can still be overwritten by the input widget.
/// 1. Each input widget accepts a list of reusable validators by parameter [InputField.validators]
///  like 'NotNull', 'Min', 'Max', 'Future', 'Past', ...
/// 1. Input widgets do not have parameters for type conversion.
///  If this is required in some case, just use your converter on parameters `initialValue` and `onSave`.
/// 1. All input widgets should have an ".adaptive" constructor allowing them to be used by Android and iOS. (Not implemented yet)
library flutter_input;

export 'src/date_helper.dart';
export 'src/input_checkbox.dart';
export 'src/input_date.dart';
export 'src/input_datepicker.dart';
export 'src/input_datetime.dart';
export 'src/input_dropdown.dart';
export 'src/input_favorite.dart';
export 'src/input_form.dart';
export 'src/input_keyboard.dart';
export 'src/input_radio.dart';
export 'src/input_rating.dart';
export 'src/input_slider.dart';
export 'src/input_spinner.dart';
export 'src/input_switch.dart';
export 'src/input_text.dart';
export 'src/input_utils.dart';
export 'src/input_validators.dart';
