// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
//
// The original source has been modified by Hajo.Lemcke@gmail.com in the following way:
// a) Added 'enabled' handling on form level
// b) Added 'dataObject' map on form level with 'path' access from fields
// c) unified parameters for input fields
//
// To avoid collisions, the following renaming took place:
//
// Flutter -> flutter_input
// ========================
// FormField -> InputField
// FormFieldState -> InputFieldState
// Form -> InputForm
// FormState -> InputFormState

import 'package:flutter/material.dart';
import 'package:flutter_input/src/input_utils.dart';

/// A container to group input fields for data manipulation.
/// It allows enabling / disabling, validation and saving of all input fields.
/// It can provide an [InputDecoration] which is used by the input fields.
///
/// It optionally accepts a map. This map can provide initial values for input fields and
/// input fields will save their final value into this map on save.
///
/// - - - - - - - - - - - Regularly check this issues in GitHub - - - - - - - - - -
///
/// Remove attribute readOnly in TextField and TextFormField
/// https://github.com/flutter/flutter/issues/45604
///
/// Integrate enable/disable into FormState and FormField
/// https://github.com/flutter/flutter/issues/45606
///
/// Add handling of maps in `Form` and `FormField` => CLOSED (see #46073)
/// https://github.com/flutter/flutter/issues/45609
///
/// Provide input widgets to easily build data maniplulation forms
/// https://github.com/flutter/flutter/issues/46073
///
class InputForm extends StatefulWidget {
  /// If true, form fields will validate and update their error text
  /// immediately after every change. Otherwise, you must call
  /// [InputFormState.validate] to validate.
  final bool autovalidate;

  /// Required widget. Normally a layout widget which contains the input fields.
  final Widget child;

  /// Decoration used by children like input fields.
  final InputDecoration decoration;

  /// Changing 'enabled' in [InputFormState] will change 'enabled' in all descendant
  /// input fields which did not manage their enabled state by themself.
  final bool enabled;

  /// Called when one of the form fields changes.
  ///
  /// In addition to this callback being invoked, all the form fields themselves
  /// will rebuild.
  final ValueChanged onChanged;

  /// Called by InputForm.save()
  final ValueSetter onSaved;

  /// Enables the form to veto attempts by the user to dismiss the [ModalRoute]
  /// that contains the form.
  ///
  /// If the callback returns a Future that resolves to false, the form's route
  /// will not be popped.
  ///
  /// See also:
  ///
  ///  * [WillPopScope], another widget that provides a way to intercept the
  ///    back button.
  final WillPopCallback onWillPop;

  /// The 'value' is a nested map used by input fields.
  /// All descendant input fields will retain their initial value from it
  /// and will update changes into it.
  final Map<String, dynamic> value;

  ///
  /// Constructor
  ///
  /// @param dataObject json map containing data to prefill input widgets
  /// @param enabled defaults to 'true'. Can be modified in state. Updates all input widgets
  /// @param child container for input widgets
  ///
  InputForm({
    Key key,
    this.autovalidate = false,
    @required this.child,
    this.decoration,
    this.enabled = true,
    this.onChanged,
    this.onSaved,
    this.onWillPop,
    this.value,
  })  : assert(child != null),
        assert(enabled != null),
        super(key: key);

  /// Returns the closest [InputFormState] which encloses the given context.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// InputFormState form = InputForm.of(context);
  /// form.save();
  /// ```
  static InputFormState of(BuildContext context) {
    final _InputFormScope scope =
        context.dependOnInheritedWidgetOfExactType<_InputFormScope>();
    return scope?._formState;
  }

  @override
  InputFormState createState() => InputFormState();
}

/// State associated with an [InputForm] widget.
///
/// An [InputFormState] object can be used to [enable], [save], [reset], and [validate]
/// every [InputFormField] that is a descendant of the associated [InputForm].
///
/// Typically obtained via [InputForm.of].
class InputFormState extends State<InputForm> {
  bool _enabled;

  /// If the form fields are enabled to accept user input or not
  bool isEnabled() => _enabled;

  set enabled(bool newValue) {
    if (_enabled != newValue) {
      setState(() {
        _enabled = newValue;
        for (InputFieldState<dynamic> field in _fields) {
          if (field._enabledByForm) {
            field._enabled = newValue;
          }
        }
      });
    }
  }

  int _generation = 0;
  final Set<InputFieldState<dynamic>> _fields = {};

  Map<String, dynamic> get value => widget.value;

  @override
  void initState() {
    super.initState();
    _enabled = widget.enabled ?? true;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.autovalidate) _validate();
    return WillPopScope(
      onWillPop: widget.onWillPop,
      child: _InputFormScope(
        formState: this,
        generation: _generation,
        child: widget.child,
      ),
    );
  }

  /// Resets every [InputField] that is a descendant of this [InputForm] back to its
  /// [InputField.initialState].
  ///
  /// The [InputForm.onChanged] callback will be called.
  ///
  /// If the form's [InputForm.autovalidate] property is true, the fields will all be
  /// revalidated after being reset.
  void reset() {
    for (InputFieldState<dynamic> field in _fields) {
      field.reset();
    }
    _fieldDidChange();
  }

  /// Saves every [InputField] that is a descendant of this [InputForm].
  void save() {
    for (InputFieldState<dynamic> field in _fields) {
      field.save();
    }
  }

  /// Validates every [InputField] that is a descendant of this [InputForm], and
  /// returns true if there are no errors.
  ///
  /// The form will rebuild to report the results.
  bool validate() {
    _forceRebuild();
    return _validate();
  }

  // Called when a form field has changed. This will cause all form fields
  // to rebuild, useful if form fields have interdependencies.
  void _fieldDidChange() {
    if (widget.onChanged != null) {
      widget.onChanged(widget.value);
    }
    _forceRebuild();
  }

  void _forceRebuild() {
    setState(() {
      ++_generation;
    });
  }

  void _register(InputFieldState<dynamic> field) {
    _fields.add(field);
  }

  void _unregister(InputFieldState<dynamic> field) {
    _fields.remove(field);
  }

  bool _validate() {
    bool hasError = false;
    for (InputFieldState<dynamic> field in _fields) {
      hasError = !field.validate() || hasError;
    }
    return !hasError;
  }
}

class _InputFormScope extends InheritedWidget {
  const _InputFormScope({
    Key key,
    Widget child,
    InputFormState formState,
    int generation,
  })  : _formState = formState,
        _generation = generation,
        super(key: key, child: child);

  final InputFormState _formState;

  /// Incremented every time a field has changed. This lets us know when
  /// to rebuild the form.
  final int _generation;

  /// The [InputForm] associated with this widget.
  InputForm get form => _formState.widget;

  @override
  bool updateShouldNotify(_InputFormScope old) => _generation != old._generation;
}

/// Signature for validating a form field.
///
/// Returns an error string to display if the input is invalid, or null otherwise.
///
/// Used by [InputField.validators].
typedef InputValidator = String Function(dynamic value);

/// Signature for being notified when a form field changes value.
///
/// Used by [InputField.onSaved].
typedef InputFieldSetter<T> = void Function(T newValue);

/// Transform a value of type T into a value of type S.
///
/// Used by [InputField.transformOnLoad] and by [InputField.transformOnSave].
typedef ValueTransformer<S, T> = S Function(T value);

/// A single form field.
///
/// This widget maintains the current state of the form field, so that updates
/// and validation errors are visually reflected in the UI.
///
/// When used inside an [InputForm], you can use methods on [InputFormState] to query or
/// manipulate the form data as a whole. For example, calling [InputFormState.save]
/// will invoke each [InputField]'s [onSaved] callback in turn.
///
/// Use a [GlobalKey] with [InputField] if you want to retrieve its current
/// state, for example if you want one field to depend on another.
///
/// An [InputForm] ancestor is not required. The [InputForm] simply makes it easier to
/// enable, save, reset, or validate multiple fields at once. To use without an [InputForm],
/// pass a [GlobalKey] to the constructor and use [GlobalKey.currentState] to
/// save or reset the field.
///
/// See also:
///
///  * [InputForm], which is the widget that aggregates the fields.
///  * [InputText], which is a commonly used field for entering text.
abstract class InputField<T> extends StatefulWidget {
  /// Creates a single form field.
  ///
  /// The [builder] argument must not be null.
  const InputField({
    Key key,
    this.autovalidate = false,
    this.decoration,
    this.enabled,
    this.initialValue,
    this.onChanged,
    this.onSaved,
    this.path,
    this.validators,
  })  : assert(initialValue != null || path != null,
            'If path is null then initialValue is required'),
        super(key: key);

  /// If true, this form field will validate and update its error text
  /// immediately after every change. Otherwise, you must call
  /// [InputFieldState.validate] to validate. If part of an [InputForm] that
  /// auto-validates, this value will be ignored.
  final bool autovalidate;

  /// Decoration for the input field supplying frame, label, error text, ...
  final InputDecoration decoration;

  /// Whether the form is able to receive user input.
  ///
  /// Defaults to true. If [autovalidate] is true, the field will be validated.
  /// Likewise, if this field is false, the widget will not be validated
  /// regardless of [autovalidate].
  final bool enabled;

  /// An optional value to initialize the field to. It will be preceded by
  /// dataObject[path] if an ancestor [InputForm] exists.
  final T initialValue;

  /// An optional method to call on every change of the fields value.
  final ValueSetter<T> onChanged;

  /// An optional method to call with the final value when the form is saved via
  /// [InputFormState.save].
  final ValueSetter<T> onSaved;

  /// The path into the [InputForm]s dataObject. Path elements must be dot separated.
  final String path;

  /// An optional method that validates an input. Returns an error string to
  /// display if the input is invalid, or null otherwise.
  ///
  /// The returned value is exposed by the [InputFieldState.errorText] property.
  /// The [InputText] uses this to override the [InputDecoration.errorText]
  /// value.
  ///
  /// Alternating between error and normal state can cause the height of the
  /// [InputText] to change if no other subtext decoration is set on the
  /// field. To create a field whose height is fixed regardless of whether or
  /// not an error is displayed, either wrap the  [InputText] in a fixed
  /// height parent like [SizedBox], or set the [InputText.helperText]
  /// parameter to a space.
  final List<InputValidator> validators;

  @override
  InputFieldState<T> createState() => InputFieldState<T>();
}

/// The current state of an [InputField].
class InputFieldState<T> extends State<InputField<T>> {
  bool _enabled, _enabledByForm;

  /// If the field is enabled to accept user input or not
  bool isEnabled() => _enabled;

  set enabled(bool newValue) {
    if (_enabled != newValue) {
      setState(() {
        _enabled = newValue;
        _enabledByForm = false;
      });
      _formState?._fieldDidChange();
    }
  }

  String _errorText;

  /// The current validation error returned by the [InputField.validator]
  /// callback, or null if no errors have been triggered. This only updates when
  /// [validate] is called.
  String get errorText => _errorText;

  /// True if this field has any validation errors.
  bool get hasError => _errorText != null;

  InputFormState _formState;
  T value;

  Widget buildInputField(BuildContext context, Widget builder) {
    if (widget.autovalidate && _enabled) {
      _validate();
    }
    final InputDecoration effectiveDecoration =
        (widget.decoration ?? const InputDecoration())
            .applyDefaults(Theme.of(context).inputDecorationTheme)
            .copyWith(errorText: errorText);
    return InputDecorator(
      child: builder,
      decoration: effectiveDecoration,
    );
  }

  @override
  void deactivate() {
    _formState?._unregister(this);
    super.deactivate();
  }

  /// Updates this field's state to the new value. Useful for responding to
  /// child widget changes, e.g. [Slider]'s [Slider.onChanged] argument.
  ///
  /// Triggers the [InputForm.onChanged] callback and, if the [InputForm.autovalidate]
  /// field is set, revalidates all fields of the form.
  void didChange(T newValue) {
    if (value == newValue) {
      return;
    }
    setState(() {
      value = newValue;
    });
    _formState?._fieldDidChange();
    if (widget.onChanged != null) {
      widget.onChanged(value);
    }
  }

  @override
  @mustCallSuper
  void initState() {
    super.initState();
    _formState = context.findAncestorStateOfType<InputFormState>();
    _formState?._register(this);
    _initEnabled();
    _initValue();
  }

  void _initEnabled() {
    _enabledByForm = false;
    if (widget.enabled != null) {
      _enabled = widget.enabled;
    } else if (_formState == null) {
      _enabled = true;
    } else {
      _enabled = _formState._enabled ?? true;
      _enabledByForm = true;
    }
  }

  void _initValue() {
    dynamic valueLoaded =
        widget.initialValue ?? InputUtils.readJson(_formState?.widget?.value, widget.path);
    value = InputUtils.convertToType(T, valueLoaded);
  }

  /// Resets the field to its initial value.
  void reset() {
    setState(() {
      _errorText = null;
      _initValue();
    });
  }

  /// Calls the [InputField]'s onSaved method with the current value. If [onSaved] is null
  /// then it writes the value at [path] into [InputForm.value].
  void save() {
    if (widget.onSaved != null) {
      widget.onSaved(value);
    } else if (widget.path != null) {
      InputUtils.writeJson(_formState?.widget?.value, widget.path, value);
    }
  }

  /// Sets the value associated with this form field.
  ///
  /// This method should only be called by subclasses that need to update
  /// the field value due to state changes identified during the widget
  /// build phase, when calling `setState` is prohibited. In all other cases,
  /// the value should be set by a call to [didChange], which ensures that
  /// `setState` is called.
  @protected
  void setValue(T newValue) {
    value = newValue;
  }

  /// Calls [InputField.validators] to set the [errorText]. Returns true if there
  /// were no errors.
  bool validate() {
    setState(() {
      _validate();
    });
    return !hasError;
  }

  void _validate() {
    if (widget.validators != null) {
      for (InputValidator validator in widget.validators) {
        _errorText = validator(value);
        if (_errorText != null) {
          break;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError('InputField.build() must never be called.'
        ' Check exception stack!');
  }
}
