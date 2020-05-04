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

/// - - - - - - - - Regularly check this issues in GitHub - - - - - - -
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
/// Provide input widgets to easily build data manipulation forms
/// https://github.com/flutter/flutter/issues/46073
///
class InputForm extends StatefulWidget {
  /// Automatically saves changed values in fields.
  /// Also invokes forms method [onSaved].
  /// Default is `true`.
  /// This value can be overwritten by each field.
  /// If `autovalidate` is true then a changed value
  /// will only be saved if validation succeeds.
  final bool autosave;

  /// Automatically validates changed values in input fields.
  /// Default is `false`.
  /// This value can be overwritten by each field.
  final bool autovalidate;

  /// The child is normally a layout widget which contains the input fields.
  final Widget child;

  /// Decoration used by the input fields.
  final InputDecoration decoration;

  /// Enables or disables user input on all fields.
  /// Default is `true`.
  /// This value can be overwritten by each field.
  final bool enabled;

  /// All descendant input fields will retain their initial value
  /// from this map and will update changes into it
  /// if they have parameter [path] set.
  final Map<String, dynamic> map;

  /// Called when one of the form fields changes.
  ///
  /// In addition to this callback being invoked,
  /// all the form fields will rebuild.
  final ValueChanged onChanged;

  /// Called by [InputForm.save()]
  final ValueSetter onSaved;

  /// Enables the form to veto attempts by the user
  /// to dismiss the [ModalRoute] that contains the form.
  ///
  /// If the callback returns a Future that resolves to false,
  /// the form's route will not be popped.
  ///
  /// See also:
  ///
  ///  * [WillPopScope], another widget that provides a way to intercept the
  ///    back button.
  final WillPopCallback onWillPop;

  /// A container to group input widgets (fields) for data manipulation.
  /// It provides parameters which are used by all fields
  /// and methods which invoke the corresponding method in all fields.
  /// It can provide an [InputDecoration] which is used by all fields.
  ///
  /// The optional [map] provides initial values to fields
  /// and stores changed values.
  InputForm({
    Key key,
    this.autosave = true,
    this.autovalidate = false,
    @required this.child,
    this.decoration,
    this.enabled = true,
    this.map,
    this.onChanged,
    this.onSaved,
    this.onWillPop,
  })  : assert(autosave != null),
        assert(autovalidate != null),
        assert(child != null),
        assert(enabled != null),
        super(key: key);

  /// Returns the closest [InputFormState] which encloses the given context.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// InputFormState _form = InputForm.of(context);
  /// if ( _form.validate()) {
  ///   _form.save();
  /// }
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
/// An [InputFormState] can be used to [enable()], [reset()], [save()]
/// or [validate()] all fields.
///
/// Typically obtained via [InputForm.of].
class InputFormState extends State<InputForm> {
  int _generation = 0;
  final Set<InputFieldState<dynamic>> _fields = {};

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

  /// Resets every [InputField] attached to this form.
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
      widget.onChanged(widget.map);
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
    bool _fieldHasError, _formHasError = false;
    for (InputFieldState<dynamic> field in _fields) {
      _fieldHasError = !field.validate();
      _formHasError = _fieldHasError || _formHasError;
    }
    return !_formHasError;
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
  bool updateShouldNotify(_InputFormScope old) =>
      _generation != old._generation;
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

/// This base class must be extended by all input widgets.
///
/// This widget maintains the current state of the field, so that user input
/// and validation failures are visually reflected in the UI.
///
/// Use a [GlobalKey] with [InputField] if you want to retrieve its current
/// state, for example if you want one field to depend on another.
///ö
/// An [InputForm] ancestor is not required. It simply makes it easier to
/// enable, save, reset, or validate all input widgets at once.
///
/// See also:
///
///  * [InputForm] - the widget that aggregates the fields.
///  * [InputText] - a commonly used field for entering text.
abstract class InputField<T> extends StatefulWidget {
  /// Creates a single form field.
  ///
  /// The [builder] argument must not be null.
  const InputField({
    Key key,
    this.autosave,
    this.autovalidate,
    this.decoration,
    this.enabled,
    this.initialValue,
    this.map,
    this.onChanged,
    this.onSaved,
    this.path,
    this.validators,
    this.wantKeepAlive = false,
  })  : assert(
            (path != null) ||
                (onChanged != null) ||
                (onSaved != null) ||
                ((enabled != null) && (enabled == false)),
            'If path is null then onChanged is required'
            ' or the field must always be disabled'),
        assert(wantKeepAlive != null),
        super(key: key);

  /// Automatically saves a changed value.
  /// If [autovalidate] is `true` then a changed value will only
  /// be saved if there is no validation failure.
  /// Also invokes method [onSaved]. Default is `true`.
  final bool autosave;

  /// Automatically validates any change and updates error text accordingly.
  /// Default is `false`.
  final bool autovalidate;

  /// Decoration for the input field supplying frame, label, error text, ...
  final InputDecoration decoration;

  /// Whether the field accepts user input.
  /// Default is `true`.
  final bool enabled;

  /// The fields value will initially be set to this `initialValue`.
  final T initialValue;

  /// [map] is used together with [path] to provide the initial value from
  /// and to save changes to the map. This parameter supersedes parameter
  /// [map] given to an [InputForm] ancestor.
  final Map<String, dynamic> map;

  /// An optional method to call on every change of the fields value.
  final ValueSetter<T> onChanged;

  /// An optional method to call with the final value when the form is saved
  /// through [InputFormState.save()].
  final ValueSetter<T> onSaved;

  /// The path to the fields value in [map].
  /// If the form is nested then [path] elements must be dot separated.
  final String path;

  /// Methods that validate an input.
  /// The first failed validation will return an error string and no more
  /// validations will happen.
  ///
  /// The returned value is exposed by the [InputFieldState.errorText] property
  /// which will be used by the default [decoration].
  ///
  /// Alternating between error and normal state can cause the height of the
  /// field to change if no other subtext decoration is set on the field.
  /// To create a field whose height is fixed regardless of whether or
  /// not an error is displayed, either wrap the field in a fixed
  /// height parent like [SizedBox], or set the [helperText]
  /// parameter to a space.
  final List<InputValidator> validators;

  /// `true` will keep the state of all input fields within the same [Slider]
  /// even when the widget is scrolled out of view.
  final bool wantKeepAlive;

  @override
  InputFieldState<T> createState() => InputFieldState<T>();
}

/// The current state of an [InputField].
class InputFieldState<T> extends State<InputField<T>>
    with AutomaticKeepAliveClientMixin<InputField<T>> {
  String _errorText;
  // --- Set once in `initState()`
  T _initialValue;

  /// The current validation error returned by the [InputField.validator]
  /// callback, or `null` if no errors have been triggered.
  /// This updates on [reset] or [validate].
  String get errorText => _errorText;

  /// Returns `true` if this field has any validation errors.
  bool get hasError => _errorText != null;

  /// The [InputForm] to which this field has registered itself.
  InputFormState _formState;
  T value;

  /// Initializes the input field by automatically registering itself to
  /// an [InputForm] ancestor (if there is one).
  ///
  /// Enables the field by first checking parameter [enable]. If not set then
  /// checks parameter [enable] at the [InputForm] ancestor. If no ancestor or
  /// not set then defaults to `true`.
  ///
  /// Sets initially displayed value by using parameter [initialValue].
  /// If not set then uses value from [InputForm] ancestor at parameter [path].
  /// If no ancestor or not set then defaults to a widget specific value.
  @override
  @mustCallSuper
  void initState() {
    super.initState();
    _formState = context.findAncestorStateOfType<InputFormState>();
    _formState?._register(this);
    dynamic valueLoaded = widget.initialValue ??
        InputUtils.readJson(widget.map, widget.path) ??
        InputUtils.readJson(_formState?.widget?.map, widget.path);
    _initialValue = InputUtils.convertToType(T, valueLoaded);
    value = _initialValue;
  }

  /// This method must not be called directly.
  /// Use [InputField.buildInputField()] instead.
  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }

  Widget buildInputField(BuildContext context, Widget builder) {
    if (isEnabled() && (widget.autovalidate ?? false)) {
      _validate();
    }
    InputDecoration effectiveDecoration =
        InputDecoration(border: InputBorder.none)
            .applyDefaults(Theme.of(context).inputDecorationTheme);
    if (_formState?.widget?.decoration != null) {
      effectiveDecoration =
          effectiveDecoration.copyDecoration(_formState.widget.decoration);
    }
    if (widget.decoration != null) {
      effectiveDecoration =
          effectiveDecoration.copyDecoration(widget.decoration);
    }
    effectiveDecoration = effectiveDecoration.copyWith(
      errorText: errorText,
    );
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
  /// Triggers the [InputForm.onChanged] callback.
  /// Also revalidates all fields of the form if [InputForm.autovalidate]
  /// is `true`.
  void didChange(T newValue) {
    if (value == newValue) {
      return;
    }
    setState(() {
      value = newValue;
    });
    if (_hasAutosave()) {
      save();
    } else if (_hasAutovalidate()) {
      _validate();
    }
    _formState?._fieldDidChange();
    if (widget.onChanged != null) {
      widget.onChanged(value);
    }
  }

  bool isEnabled() {
    return widget.enabled ?? _formState?.widget?.enabled ?? true;
  }

  /// Resets the field to its initial value and clears error indication.
  /// Also invokes [onChanged()].
  void reset() {
    setState(() {
      _errorText = null;
      value = _initialValue;
      if (widget.onChanged != null) {
        widget.onChanged(value);
      }
    });
  }

  /// Saves a changed field value by invoking [onSave()]
  /// and writing value at [path] into [map].
  ///
  /// If [autovalidate] is `true` then validation will be performed first.
  /// If it fails, then the value will not be saved.
  void save() {
    if (_hasAutovalidate() && (_validate() == false)) {
      return;
    }
    if (widget.onSaved != null) {
      widget.onSaved(value);
    }
    InputUtils.writeJson(
        widget.map ?? _formState?.widget?.map, widget.path, value);
    _initialValue = value;
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

  /// Calls [InputField.validators] to set the [errorText].
  /// Returns `true` if all validations succeed.
  bool validate() {
    setState(() {
      _validate();
    });
    return !hasError;
  }

  /// Whenever [wantKeepAlive] should change
  /// then [updateKeepAlive] must be called.
  @override
  void updateKeepAlive() {
    super.updateKeepAlive();
  }

  @override
  bool get wantKeepAlive => widget.wantKeepAlive;

  bool _hasAutosave() {
    return widget.autosave ?? _formState?.widget?.autosave ?? true;
  }

  bool _hasAutovalidate() {
    return widget.autovalidate ?? _formState?.widget?.autovalidate ?? false;
  }

  bool _validate() {
    if (widget.validators != null) {
      for (InputValidator validator in widget.validators) {
        _errorText = validator(value);
        if (_errorText != null) {
          return false;
        }
      }
    }
    return true;
  }
}

extension _InputDecorationExtension on InputDecoration {
  InputDecoration copyDecoration(InputDecoration deco) {
    return InputDecoration(
      icon: deco.icon ?? icon,
      labelText: deco.labelText ?? labelText,
      labelStyle: deco.labelStyle ?? labelStyle,
      helperText: deco.helperText ?? helperText,
      helperStyle: deco.helperStyle ?? helperStyle,
      helperMaxLines: deco.helperMaxLines ?? helperMaxLines,
      hintText: deco.hintText ?? hintText,
      hintStyle: deco.hintStyle ?? hintStyle,
      hintMaxLines: deco.hintMaxLines ?? hintMaxLines,
      errorText: deco.errorText ?? errorText,
      errorStyle: deco.errorStyle ?? errorStyle,
      errorMaxLines: deco.errorMaxLines ?? errorMaxLines,
//      // ignore: deprecated_member_use_from_same_package
//      hasFloatingPlaceholder:
//          hasFloatingPlaceholder ?? this.hasFloatingPlaceholder,
//      floatingLabelBehavior:
//          deco.floatingLabelBehavior ?? this.floatingLabelBehavior,
      isDense: deco.isDense ?? isDense,
      contentPadding: deco.contentPadding ?? contentPadding,
      prefixIcon: deco.prefixIcon ?? prefixIcon,
      prefix: deco.prefix ?? prefix,
      prefixText: deco.prefixText ?? prefixText,
      prefixStyle: deco.prefixStyle ?? prefixStyle,
      suffixIcon: deco.suffixIcon ?? suffixIcon,
      suffix: deco.suffix ?? suffix,
      suffixText: deco.suffixText ?? suffixText,
      suffixStyle: deco.suffixStyle ?? suffixStyle,
      counter: deco.counter ?? counter,
      counterText: deco.counterText ?? counterText,
      counterStyle: deco.counterStyle ?? counterStyle,
      filled: deco.filled ?? filled,
      fillColor: deco.fillColor ?? fillColor,
      focusColor: deco.focusColor ?? focusColor,
      hoverColor: deco.hoverColor ?? hoverColor,
      errorBorder: deco.errorBorder ?? errorBorder,
      focusedBorder: deco.focusedBorder ?? focusedBorder,
      focusedErrorBorder: deco.focusedErrorBorder ?? focusedErrorBorder,
      disabledBorder: deco.disabledBorder ?? disabledBorder,
      enabledBorder: deco.enabledBorder ?? enabledBorder,
      border: deco.border ?? border,
      enabled: deco.enabled ?? enabled,
      semanticCounterText: deco.semanticCounterText ?? semanticCounterText,
      alignLabelWithHint: deco.alignLabelWithHint ?? alignLabelWithHint,
    );
  }
}
