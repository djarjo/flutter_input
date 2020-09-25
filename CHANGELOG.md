## 1.4.0

ATTENTION: There is a breaking change when accessing nested maps.
From this version on the separation character is a single slash `/`.
It was a single dot `.` before.
The forward slash better resembles a path and also allows dots in keys.

- each input field automatically creates a `FocusNode` if none
is given (!!! Must be disposed !!!)
- new class `InputViolation` provides `InputField.key`,
`InputField.focusNode`, `InputField.value`
and the failed validation
- added `InputViolation getFirstViolation()` on each input field
to get the first failed validation.
- `InputCheckbox`: added properties `mouseCursor` and `visualDensity`
- `InputKeyboard`: added properties `autofillHints, map, 
 mouseCursor, obscuringCharacter, scrollController, scrollPhysics,
 selectionHeightStyle, selectionWidthStyle, smartDashesType, smartQuoteTyp`
- `InputRadio`: added properties `hoverColor, mouseCursor`
- `InputSwitch`: added properties `activeThumbImage,
 activeTrackColor, autofocus, dragStartBehavior, focusColor,
 focusNode, hoverColor, inactiveThumbColor, inactiveThumbImage,
 inactiveTrackColor, materialTapTargetSize, mouseCursor,
 onActiveThumbImageError, onInactiveThumbImageError`


## 1.3.0

- Added new parameters on all input fields:
`bool autosave (true)`, `bool autofocus (false)`, `FocusNode focusNode`
- Code cleanup in `input_form.dart` results in more proper handling
of parameter values. Order is always `InputWidget` then `InputForm`
then a widget specific default value.
- Renamed parameter `InputForm.value` to `InputForm.map`
- Added parameter `map` on every input widget
- `InputDatePicker` now has default styles
- Fixed handling of enable/disable on `InputCountry`

## 1.2.0

- Fixed assertion on InputField when using InputKeyboard
- Added `InputPassword` showing characters on demand
- Added parameter `wantKeepAlive` on all widgets to
  keep widget state even when scrolled out of view

## 1.1.2

- Moved flag images to `lib/assets`

## 1.1.1

- Fixed flutter version problem:
 _The getter 'floatingLabelBehavior' isn't defined for the class 'InputDecoration'_
- Fixed pub.dev analysis problem with class local instance variable.

## 1.1.0

- Localized widgets by using a combination of Flutter localization
 and package `i18n_extension`.
- Added `Country`. Contains list of countries based on ISO-3166 and flag images.
- Added `InputCountry` to select a country from a (filterable) list.
 The list is automatically sorted by localized country name.
 Flag of country is shown.
- Added `InputLanguage` to select a language from a list of available languages.
- Default field decoration now is without underline for non-text fields.
- Bugfix: properly nested decoration from Default -> Theme -> Form -> Field.
- Bugfix: editing some fields within a form, then abort editing
 wrongly displayed the edited value.

## 1.0.3

- renamed `InputCalendar` to `InputDatePicker` because we are working
 on a calendar widget containing events. Sorry for any inconvenience.
- added first animated gif. Shows the date picker.

## 1.0.2

- `InputSpinner` now accepts a generic of type `int` or `double`.
- Date utility methods (e.g. `weekOfYear` or `julianDay`) changed
 to Dart extensions. Can now be used on all `DateTime` objects.
- Bugfix: closing `InputCalendar` with \[X\] did set value to null

## 1.0.1
- Breaking change: all validator functions are now lowerCamelCase

## 1.0.0

- Added new widget `InputKeyboard`.
 Generic type `<String>, <int> or <double>` automatically sets appropriate keyboard. 
 Replaces deprecated `InputText`.
- Added new widget `InputCalendar` which is a highly customizable
 date picker. It shows weeks of year.
 Month selection by dragging the whole calendar sheet left or right
 or using the month dropdown.
 Year can be directly set as it is a text input field.
- Added `DateHelper` with methods `getJulianDay()`,
 `getWeekOfYear()`, `isSameDay()`, `isBetween()` and more.
- All fields are included in the example project.
- Made better documentation.

## 0.2.0

- Added new widget `InputSlider`
- Added new widget `InputSpinner`
- Added some reusable validators: `NotNull, Min, MinLength, Max, MaxLength`
- Validators can have individual error messages with named parameter `message`

## 0.1.0

- Initial version
