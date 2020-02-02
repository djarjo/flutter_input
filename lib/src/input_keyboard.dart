// Copyright 2020 Hajo.Lemcke@mail.com
// Please see the LICENSE file for details.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'input_form.dart';
import 'input_utils.dart';

/// An [InputField] that contains a [TextField] for one of type [String], [int] or [double].
///
/// The value type is specified by a generic.
///
/// An [InputForm] ancestor is not required.
/// It simply makes it easier to enable, save, reset, or validate multiple fields at once.
///
/// {@tool sample}
///
/// Creates a [InputKeyboard] with an [InputDecoration] and validators.
///
/// ![If the user enters valid input, the field appears normally without any warnings to the user]
///
/// ![If the user enters invalid text, the error message returned from the first failed validator
/// function will be displayed in dark red underneath the input]
///
/// ```dart
/// InputKeyboard<String>(
///   decoration: InputDecoration(
///     labelText: 'Name *',
///     icon: Icon(Icons.person),
///     hintText: 'What do people call you?',
///   ),
///   path: 'user.name',
///   validators: [(v) => NotNull(), (v) => MinLen(v, 7), message: 'Must be at least 7 chars long'), ],
/// )
/// ```
/// {@end-tool}
///
/// See also:
/// [InputField] for a documentation about the common parameters.
/// [TextField] for a documentation about the specific parameters.
class InputKeyboard<T> extends InputField<T> {
  /// Creates an [InputField] that contains a [TextField].
  ///
  /// When a [controller] is specified, [initialValue] must be null (the
  /// default). If [controller] is null, then a [TextEditingController]
  /// will be constructed automatically and its `text` will be initialized
  /// to [initialValue] or the empty string.
  ///
  /// For documentation about the various parameters, see the [TextField] class
  /// and [new TextField], the constructor.
  InputKeyboard({
    Key key,
    this.autocorrect = true,
    this.autofocus = false,
    bool autovalidate = false,
    this.buildCounter,
    this.controller,
    this.cursorColor,
    this.cursorRadius,
    this.cursorWidth = 2.0,
    InputDecoration decoration,
    bool enabled,
    this.enableInteractiveSelection = true,
    this.enableSuggestions = true,
    this.expands = false,
    this.focusNode,
    T initialValue,
    this.inputFormatters,
    this.keyboardAppearance,
    this.keyboardType,
    this.maxLength,
    this.maxLengthEnforced = true,
    this.maxLines = 1,
    this.minLines,
    this.obscureText = false,
    ValueChanged<T> onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    InputFieldSetter<T> onSaved,
    this.onTap,
    String path,
    this.showCursor,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.strutStyle,
    this.style,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textCapitalization = TextCapitalization.none,
    this.textDirection,
    this.textInputAction,
    this.toolbarOptions,
    List<InputValidator> validators,
  })  : assert(
          T == String || T == int || T == double,
          'Generic must be one of String, int or double',
        ),
        assert(autocorrect != null),
        assert(autofocus != null),
        assert(autovalidate != null),
        assert(enableInteractiveSelection != null),
        assert(enableSuggestions != null),
        assert(initialValue == null || controller == null),
        assert(maxLength == null || maxLength > 0),
        assert(maxLengthEnforced != null),
        assert(maxLines == null || maxLines > 0),
        assert(minLines == null || minLines > 0),
        assert(obscureText != null),
        assert(textAlign != null),
        assert(scrollPadding != null),
        assert(
          (maxLines == null) || (minLines == null) || (maxLines >= minLines),
          'minLines can\'t be greater than maxLines',
        ),
        assert(expands != null),
        assert(
          !expands || (maxLines == null && minLines == null),
          'minLines and maxLines must be null when expands is true.',
        ),
        assert(!obscureText || maxLines == 1, 'Obscured fields cannot be multiline.'),
        super(
          key: key,
          autovalidate: autovalidate,
          decoration: decoration,
          enabled: enabled,
          initialValue: controller != null ? controller.text : initialValue,
          onSaved: onSaved,
          path: path,
          validators: validators,
        );

  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController] and
  /// initialize its [TextEditingController.text] with [initialValue].
  final TextEditingController controller;
  final bool autocorrect, autofocus;
  final InputCounterWidgetBuilder buildCounter;
  final Color cursorColor;
  final Radius cursorRadius;
  final double cursorWidth;
  final bool enableInteractiveSelection, enableSuggestions, expands;
  final FocusNode focusNode;
  final List<TextInputFormatter> inputFormatters;
  final Brightness keyboardAppearance;
  final TextInputType keyboardType;
  final int maxLength;
  final bool maxLengthEnforced;
  final int maxLines, minLines;
  final bool obscureText;
  final VoidCallback onEditingComplete;
  final ValueChanged<String> onFieldSubmitted;
  final GestureTapCallback onTap;
  final bool showCursor;
  final EdgeInsets scrollPadding;
  final StrutStyle strutStyle;
  final TextStyle style;
  final TextAlign textAlign;
  final TextAlignVertical textAlignVertical;
  final TextCapitalization textCapitalization;
  final TextDirection textDirection;
  final TextInputAction textInputAction;
  final ToolbarOptions toolbarOptions;

  @override
  _InputKeyboardState<T> createState() => _InputKeyboardState<T>();
}

/// -------------------------------------------------------
class _InputKeyboardState<T> extends InputFieldState<T> {
  TextEditingController _controller;
  TextInputType _keyboardType;

  TextEditingController get _effectiveController => widget.controller ?? _controller;

  @override
  InputKeyboard<T> get widget => super.widget;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = TextEditingController(text: super.value?.toString());
    } else {
      widget.controller.addListener(_handleControllerChanged);
    }
    if (T == int) {
      _keyboardType = TextInputType.numberWithOptions(decimal: false, signed: true);
    } else if (T == double) {
      _keyboardType = TextInputType.numberWithOptions(decimal: true, signed: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final InputDecoration effectiveDecoration =
        (widget.decoration ?? const InputDecoration())
            .applyDefaults(Theme.of(context).inputDecorationTheme);

    void onChangedHandler(String fieldValue) {
      if (fieldValue == null || fieldValue.isEmpty) {
        return;
      }
      T newValue = InputUtils.convertToType(T, fieldValue);
      if (widget.onChanged != null) {
        widget.onChanged(newValue);
      }
      didChange(newValue);
    }

    return TextField(
      autocorrect: widget.autocorrect,
      autofocus: widget.autofocus,
      buildCounter: widget.buildCounter,
      controller: _effectiveController,
      cursorColor: widget.cursorColor,
      cursorRadius: widget.cursorRadius,
      cursorWidth: widget.cursorWidth,
      decoration: effectiveDecoration.copyWith(errorText: errorText),
      enabled: super.isEnabled(),
      enableInteractiveSelection: widget.enableInteractiveSelection,
      enableSuggestions: widget.enableSuggestions,
      expands: widget.expands,
      focusNode: widget.focusNode,
      keyboardAppearance: widget.keyboardAppearance,
      keyboardType: _keyboardType,
      inputFormatters: widget.inputFormatters,
      maxLength: widget.maxLength,
      maxLengthEnforced: widget.maxLengthEnforced,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      obscureText: widget.obscureText,
      onChanged: onChangedHandler,
      onEditingComplete: widget.onEditingComplete,
      onSubmitted: widget.onFieldSubmitted,
      onTap: widget.onTap,
      readOnly: false,
      scrollPadding: widget.scrollPadding,
      showCursor: widget.showCursor,
      style: widget.style,
      strutStyle: widget.strutStyle,
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
      textCapitalization: widget.textCapitalization,
      textDirection: widget.textDirection,
      textInputAction: widget.textInputAction,
      toolbarOptions: widget.toolbarOptions,
    );
  }

  @override
  void didUpdateWidget(InputKeyboard<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null) {
        _controller = TextEditingController.fromValue(oldWidget.controller.value);
      }
      if (widget.controller != null) {
        T newValue = InputUtils.convertToType(T, widget.controller.text);
        setValue(newValue);
        if (oldWidget.controller == null) _controller = null;
      }
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    super.dispose();
  }

  @override
  void reset() {
    super.reset();
    _controller.text = (super.value == null) ? null : super.value.toString();
  }

  void _handleControllerChanged() {
    // Suppress changes that originated from within this class.
    //
    // In the case where a controller has been passed in to this widget, we
    // register this change listener. In these cases, we'll also receive change
    // notifications for changes originating from within this class -- for
    // example, the reset() method. In such cases, the FormField value will
    // already have been set.
    if (_effectiveController.text != value) {
      T newValue = InputUtils.convertToType(T, _effectiveController.text);
      didChange(newValue);
    }
  }
}
