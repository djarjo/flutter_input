// Copyright 2020 Hajo.Lemcke@gmail.com
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
    Map<String, dynamic> map,
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
          onChanged: isEnabled() ? (v) => super.didChange(v) : null,
          value: value ?? false,
        ),
      ),
    );
  }
}
