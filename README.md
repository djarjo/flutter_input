# Flutter Input Fields standalone or within a Form &rarr; <i>flutter_input</i>
This package provides an `InputForm` and a set of input fields.
Each input field can be used standalone or as part of a form.

This package is an early version of the architectural ideas
described below.
It still has issues especially concerning decoration.
Developers are highly welcomed :-)

The main goal of this package is to provide ideas and input
for data management with Flutter.
My hope is that it becomes maintained by the Flutter team or
be integrated with other similar packages.

Please see and vote issue https://github.com/flutter/flutter/issues/46073
on GitHub.

## Input fields
Currently the following input fields are supported:
* `InputCheckbox` - Checkbox for data type `bool`
* `InputDate` - Calendar selection for data type `DateTime`
* `InputDateTime` - Sliders for data type `DateTime` can be customized for date only, time only or both
* `InputDropDown<T>` - Dropdown button for data type `T`
* `InputFavorite` - A favorite button with selectable icon for data type `bool`
* `InputRadio<T>` - Radio button to select one value of type `T`
* `InputRating` - Rating widget with selectable icons and a range selector for data type `int`
* `InputSlider` - Slider for data type `double` between a minimum and maximum value
* `InputSpinner` - Spinner with buttons for data type `double` to decrease or increase a value
 between a minimum and maximum
* `InputSwitch` - Switch for data type `bool`
* `InputText` - Text input for data type `String`

## Architecture
This package is based on the following design criteria:
1. Provide an easy to understand package for data input which is
easy to use, to maintain and to extend
1. Have a form to manage one data object (a `Map`) for all fields
providing a central method to `validate()` and `save()`.
1. Fields access this map by means of a `path` string to get
an initial value and to save back the fields value.
1. Fields can be used stand alone, even within a form.
To achieve this, `path` must be `null` and `onChanged` must not.
1. Widget attributes with same functionality should have same names
(unlike 'initialValue' and 'value' or 'onChanged' and 'onValueChanged')
1. All fields have a common set of attributes
1. Have as much layout design to the form as possible
(can still be overwritten by each field-widget)
1. Each input field should auto-assign itself to the form
(requires attribute `path`).
1. Each input widget should accept a list of reusable validators like
'NotNull', 'Min', 'Max', 'Future', 'Past', ...
1. Input fields do not have standard parameters for data type conversion.
If this is required in some case, just use your converter on parameters
`initialValue` and `onSave`.
1. All input fields should have an ".adaptive" constructor
 allowing them to be used by Android and iOS. (Not implemented yet)


## Usage

For a complete example see `example/main.dart`.

All field constructors have the following shared parameters.
All parameters are named and optional.

* Key key
* `bool autovalidate = false` // 
* InputDecoration decoration - e.g. for a label
* bool enabled - to protect the field against changes. Overrides
setting through the `Form`
* T initialValue - to set the fields initial value. Overrides using
the value from the forms map.
* ValueSetter<T> onChanged - invoked on every change
 of the input field value
* ValueSetter<T> onSaved - additionally invoked by `Form.save()`
* String path - to access the form map
* List<InputValidator> validators - list of validators


## Development
To create a new input field for data type `T` just copy one of the existing
classes and modify it accordingly. Replace T with the type of the value of
your new input field.
1. Create a new stateful widget for type `T` with
`class MyNewInputWidget extends InputField<T> {`
1. `class MyNewInputState extends InputFieldState<T> {`
 where T is replaced by the type of the value of the field.
1. Write method `build( BuildContext context)` in the state class.
 It must end with `return super.buildInputField( context, ...` where
 `...` is the code to display your input field widget.
