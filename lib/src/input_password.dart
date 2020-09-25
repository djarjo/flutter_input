// Copyright 2020 Hajo.Lemcke@mail.com
// Please see the LICENSE file for details.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../flutter_input.dart';
import 'input_form.dart';

/// Provides a text input field to enter a password.
/// A button allows to make the password visible.
class InputPassword extends InputField<String> {
  InputPassword({
    Key key,
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
    this.expands = false,
    this.focusNode,
    this.inputFormatters,
    this.keyboardAppearance,
    this.keyboardType,
    Map<String, dynamic> map,
    this.maxLength,
    this.maxLengthEnforced = true,
    ValueChanged<String> onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    InputFieldSetter<String> onSaved,
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
    this.visibilityIcon = Icons.remove_red_eye,
    this.wantKeepAlive = false,
  })  : assert(autofocus != null),
        assert(autovalidate != null),
        assert(enableInteractiveSelection != null),
        assert(maxLength == null || maxLength > 0),
        assert(maxLengthEnforced != null),
        assert(textAlign != null),
        assert(scrollPadding != null),
        assert(expands != null),
        super(
          key: key,
          autovalidate: autovalidate,
          decoration: decoration,
          enabled: enabled,
          map: map,
          onChanged: onChanged,
          onSaved: onSaved,
          path: path,
          validators: validators,
        );

  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController] and
  /// initialize its [TextEditingController.text] with [initialValue].
  final TextEditingController controller;
  final bool autofocus;
  final InputCounterWidgetBuilder buildCounter;
  final Color cursorColor;
  final Radius cursorRadius;
  final double cursorWidth;
  final bool enableInteractiveSelection, expands;
  final FocusNode focusNode;
  final List<TextInputFormatter> inputFormatters;
  final Brightness keyboardAppearance;
  final TextInputType keyboardType;
  final int maxLength;
  final bool maxLengthEnforced;
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
  /// Icon on button to make password visible. `null` disables the button.
  final IconData visibilityIcon;
  @override
  final bool wantKeepAlive;

  @override
  _InputPasswordState createState() => _InputPasswordState();
}

/// -------------------------------------------------------
class _InputPasswordState<T> extends InputFieldState<String> {
  TextEditingController _controller;
  bool _visible = false;

  TextEditingController get _effectiveController =>
      widget.controller ?? _controller;

  @override
  bool get wantKeepAlive => widget.wantKeepAlive;

  @override
  InputPassword get widget => super.widget;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = TextEditingController(text: super.value);
    } else {
      widget.controller.addListener(_handleControllerChanged);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final InputDecoration effectiveDecoration =
        (widget.decoration ?? const InputDecoration())
            .applyDefaults(Theme.of(context).inputDecorationTheme);
TextField textField =    TextField(
    autocorrect: false,
    autofocus: widget.autofocus,
    buildCounter: widget.buildCounter,
    controller: _effectiveController,
    cursorColor: widget.cursorColor,
    cursorRadius: widget.cursorRadius,
    cursorWidth: widget.cursorWidth,
    decoration: effectiveDecoration.copyWith(errorText: errorText),
    enabled: super.isEnabled(),
    enableInteractiveSelection: widget.enableInteractiveSelection,
    enableSuggestions: false,
    expands: widget.expands,
    focusNode: widget.focusNode,
    keyboardAppearance: widget.keyboardAppearance,
    keyboardType:
    _visible ? TextInputType.visiblePassword : TextInputType.text,
    inputFormatters: widget.inputFormatters,
    maxLength: widget.maxLength,
    maxLengthEnforced: widget.maxLengthEnforced,
    maxLines: 1,
    minLines: 1,
    obscureText: (!super.isEnabled()) || (!_visible),
    onChanged: (v) => didChange(v),
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

    return (widget.visibilityIcon == null ) ?
    textField :
      Row(
      children: [
        Flexible(
          child: textField,
        ),
        IconButton(
          icon: Icon(
            widget.visibilityIcon,
            color:
                (super.isEnabled() && _visible) ? Colors.green : Colors.black,
          ),
          onPressed: super.isEnabled()
              ? () => setState(() {
                    _visible = !_visible;
                  })
              : null,
        ),
      ],
    );
  }

  @override
  void didUpdateWidget(InputPassword oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null) {
        _controller =
            TextEditingController.fromValue(oldWidget.controller.value);
      }
      if (widget.controller != null) {
        setValue(value);
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
    _controller.text = (super.value == null) ? null : super.value;
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
      didChange(value);
    }
  }
}
