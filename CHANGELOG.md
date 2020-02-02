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
