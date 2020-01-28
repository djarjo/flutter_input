# Flutter Input Widgets - Standalone or within a Form &rarr; <i>flutter_input</i>
This package provides input widgets (fields) to manipulate basic data types.
All input widgets share a common set of parameters.
A list of validators (see below) can be attached to an input widget.
Every input widget can be used standalone or attached to the `InputForm`.
The `InputForm` provides methods to `enable()`, `reset()`, `save()` or `validate()`
all fields at once which are attached to the form.

## Input Widgets
The following input widgets are included.
See section 'Development' below for building your own input widget.
* `InputCheckbox` - Checkbox for data type `bool`
* `InputDate` - Calendar based selection for data type `DateTime` (date part only)
* `InputDatePicker` - A highly customizable date picker with week of year
* `InputDateTime` - Wheels for data type `DateTime` can be customized for date only, time only or both
* `InputDropDown<T>` - Dropdown button for data type `T`
* `InputFavorite` - A favorite button with selectable icon for data type `bool`
* `InputKeyboard` - Text input for data type `String`, `int` or `double`
* `InputRadio<T>` - Radio button to select one value of type `T`
* `InputRating` - Rating widget with selectable icons and a range slider for data type `int`
* `InputSlider` - Slider for data type `double` between a minimum and maximum value
* `InputSpinner` - Spinner with buttons for data type `double` to decrease or increase a value
 between a minimum and maximum
* `InputSwitch` - Switch for data type `bool`

### Demo
#### InputDatePicker
The highly customizable `InputDatePicker` allows you to choose a date
from a calendar page which also shows the week of the year.
It provides spinners, sliders and a dropdown to select the month.
The year can even be entered as text.
All parts can be customized by `DatePickerStyles`.
 
![Screenshot](doc/screenshots/date_picker.gif)

## Usage

For a complete example see `example/main.dart`.

All input widgets share a common set of parameters.
All parameters are named and optional.

* Key key
* `bool autovalidate = false` - automatically validates  
* InputDecoration decoration - e.g. for a label
* bool enabled - to protect the field against changes. Overrides
setting of the `Form`
* T initialValue - to set the fields initial value. Overrides using
the value from the forms map.
* ValueSetter<T> onChanged - invoked on every change
 of the input field value
* ValueSetter<T> onSaved - additionally invoked by `Form.save()`
* String path - to access the form map
* List<InputValidator> validators - list of validators

## Validators
The following validators can be given to parameter `validators`
of an input widget. Each validator accepts the optional parameter
`message` to set an individual error message if the validation fails.
* `after(DateTime date)` - validates that the field value
 is after `date`
* `before(DateTime date)` - validates that the field value
 is before `date`
* `future` - validates that the DateTime field value
 lies in the future
* `max(num maxVal)` - validates that the num field value
 is not larger than `maxVal` 
* `maxLen(num maxLen)` - validates that the length of the String
 field value is not longer than `maxLen` 
* `min(num minVal)` - validates that the num field value
 is not smaller than `minVal` 
* `minLen(num minLen)` - validates that the length of the String
 field value is not shorter than `minLen` 
* `notNull` - validates the the field value is not empty
* `past` - validates that the DateTime field value
 lies in the past

## Development
To create a new input field for data type `T` follow these steps:
1. Copy one of the included class files.
1. Rename the class widget and its state to your new one. 
1. Replace `T` with the value type of your new input field.
1. Adapt parameters and leave the call to `super()` with
 all the common parameters.
1. Adapt method `build( BuildContext context)` in the state class.
 It must end with `return super.buildInputField( context, ...` where
 `...` is the code to display your new field widget.

## Utilities
This package also contains some utilities.

* `InputUtils.convertToType()` converts a value to a given target type.
* `InputUtils.readFromJson()` reads a value from a nested map.
* `InputUtils.writeToJson()` writes a value into a nested map.
* See `date_helper.dart` for extensions on `DateTime`
 for `weekOfYear`, `julianDay` and more.

### To Do
* \[X\] create a customizable calendar picker with week numbers
* \[X\] create a text input field for int and double
* \[ \] create an input widget for a calendar with events
* \[ \] create an input widget to select multiple choices like a
 multi-select list
* \[ \] add some images to this documentation
* \[ \] internationalize the whole package 
* \[ \] add dartdoc output
