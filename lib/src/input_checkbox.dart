// Copyright 2020 Hajo.Lemcke@mail.com
// Please see the LICENSE file for details.

import 'package:flutter/material.dart';

import 'input_form.dart';

/// Provides a checkbox to manipulate a bool value.
class InputCheckbox extends InputField<bool> {
  final Color activeColor;
  final Color color;

  InputCheckbox({
    Key key,
    bool autovalidate = false,
    this.activeColor,
    this.color,
    InputDecoration decoration,
    bool enabled,
    bool initialValue,
    ValueChanged<bool> onChanged,
    ValueSetter<bool> onSaved,
    String path,
    List<InputValidator> validators,
    bool wantKeepAlive = false,
  }) : super(
          key: key,
          autovalidate: autovalidate,
          decoration: decoration,
          enabled: enabled,
          initialValue: initialValue,
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
          onChanged: isEnabled() ? (v) => super.didChange(v) : null,
          value: value ?? false,
        ),
      ),
    );
  }
}
