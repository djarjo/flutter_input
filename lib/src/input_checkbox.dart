// Copyright 2020 Hajo.Lemcke@mail.com
// Please see the LICENSE file for details.

import 'package:flutter/material.dart';

import 'input_form.dart';

/// Provides a checkbox to manipulate a bool value.
class InputCheckbox extends InputField<bool> {
  final bool autofocus;
  final Color activeColor, checkColor, focusColor, hoverColor;
  final FocusNode focusNode;
  final MaterialTapTargetSize materialTapTargetSize;
  final bool tristate;

  InputCheckbox({
    Key key,
    this.autofocus = false,
    bool autosave,
    bool autovalidate,
    this.activeColor,
    this.checkColor,
    InputDecoration decoration,
    bool enabled,
    this.focusColor,
    this.focusNode,
    this.hoverColor,
    bool initialValue,
    Map<String, dynamic> map,
    this.materialTapTargetSize,
    ValueChanged<bool> onChanged,
    ValueSetter<bool> onSaved,
    String path,
    this.tristate,
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
  _InputCheckboxState createState() => _InputCheckboxState();
}

class _InputCheckboxState extends InputFieldState<bool> {
  @override
  InputCheckbox get widget => super.widget;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return super.buildInputField(
      context,
      Align(
        alignment: Alignment.centerLeft,
        child: Checkbox(
          autofocus: widget.autofocus,
          activeColor: widget.activeColor,
          checkColor: widget.checkColor,
          focusColor: widget.focusColor,
          focusNode: widget.focusNode,
          hoverColor: widget.hoverColor,
          materialTapTargetSize: widget.materialTapTargetSize,
          onChanged: isEnabled() ? (v) => super.didChange(v) : null,
          tristate: widget.tristate ?? true,
          value: value ?? false,
        ),
      ),
    );
  }
}
