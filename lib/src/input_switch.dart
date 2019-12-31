// Copyright 2020 Hajo.Lemcke@mail.com
// Please see the LICENSE file for details.

import 'package:flutter/material.dart';

import 'input_form.dart';

/// Provides a switch to manipulate a bool value
class InputSwitch extends InputField<bool> {
  final Color activeColor;
  final Color color;

  InputSwitch({
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
        );

  @override
  _InputSwitchState createState() => _InputSwitchState();
}

class _InputSwitchState extends InputFieldState<bool> {
  @override
  InputSwitch get widget => super.widget;

  @override
  Widget build(BuildContext context) {
    return super.buildInputField(
        context,
        Row(
          children: [
            Switch.adaptive(
              onChanged: isEnabled() ? (v) => super.didChange(v) : null,
              value: value ?? false,
            ),
          ],
        ));
  }
}
