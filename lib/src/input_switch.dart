// Copyright 2020 Hajo.Lemcke@gmail.com
// Please see the LICENSE file for details.

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'input_form.dart';

/// Provides a switch to manipulate a bool value
class InputSwitch extends InputField<bool> {
  final Color activeColor;
  final ImageProvider activeThumbImage;
  final Color activeTrackColor;
  final bool autofocus;
  final Color color;
  final DragStartBehavior dragStartBehavior;
  final Color focusColor;
  final FocusNode focusNode;
  final Color hoverColor;
  final Color inactiveThumbColor;
  final ImageProvider inactiveThumbImage;
  final Color inactiveTrackColor;
  final MaterialTapTargetSize materialTapTargetSize;
  final MouseCursor mouseCursor;
  final ImageErrorListener onActiveThumbImageError, onInactiveThumbImageError;

  InputSwitch({
    Key key,
    this.autofocus,
    bool autosave,
    bool autovalidate,
    this.activeColor,
    this.activeThumbImage,
    this.activeTrackColor,
    this.color,
    InputDecoration decoration,
    this.dragStartBehavior,
    bool enabled,
    this.focusColor,
    this.focusNode,
    this.hoverColor,
    this.inactiveThumbColor,
    this.inactiveThumbImage,
    this.inactiveTrackColor,
    bool initialValue,
    Map<String, dynamic> map,
    this.materialTapTargetSize,
    this.mouseCursor,
    this.onActiveThumbImageError,
    ValueChanged<bool> onChanged,
    this.onInactiveThumbImageError,
    ValueSetter<bool> onSaved,
    String path,
    List<InputValidator> validators,
    bool wantKeepAlive = false,
  }) : super(
          key: key,
          autosave: autosave,
          autovalidate: autovalidate,
          decoration: decoration,
          enabled: enabled,
          initialValue: initialValue,
          map: map,
          onChanged: onChanged,
          onSaved: onSaved,
          path: path,
          validators: validators,
          wantKeepAlive: wantKeepAlive,
        );

  @override
  _InputSwitchState createState() => _InputSwitchState();
}

class _InputSwitchState extends InputFieldState<bool> {
  @override
  InputSwitch get widget => super.widget;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return super.buildInputField(
      context,
      Align(
        alignment: Alignment.centerLeft,
        child: Switch.adaptive(
          activeColor: widget.activeColor,
          activeThumbImage: widget.activeThumbImage,
          activeTrackColor: widget.activeTrackColor,
          autofocus: widget.autofocus,
          dragStartBehavior: widget.dragStartBehavior,
          focusColor: widget.focusColor,
          focusNode: widget.focusNode,
          hoverColor: widget.hoverColor,
          inactiveThumbColor: widget.inactiveThumbColor,
          inactiveThumbImage: widget.inactiveThumbImage,
          inactiveTrackColor: widget.inactiveTrackColor,
          materialTapTargetSize: widget.materialTapTargetSize,
          mouseCursor: widget.mouseCursor,
          onActiveThumbImageError: widget.onActiveThumbImageError,
          onChanged: isEnabled() ? (v) => super.didChange(v) : null,
          onInactiveThumbImageError: widget.onInactiveThumbImageError,
          value: value ?? false,
        ),
      ),
    );
  }
}
