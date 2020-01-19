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

