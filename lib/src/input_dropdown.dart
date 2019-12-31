// Copyright 2020 Hajo.Lemcke@mail.com
// Please see the LICENSE file for details.

import 'package:flutter/material.dart';

import 'input_form.dart';

/// Provides a drop down button for a selection list
class InputDropDown<T> extends InputField<T> {
  final Color activeColor;
  final Color color;
  final IconData icon;
  final List<DropdownMenuItem<T>> items;
  final TextStyle style;

  InputDropDown({
    Key key,
    bool autovalidate = false,
    this.activeColor,
    this.color,
    InputDecoration decoration,
    enabled,
    this.icon = Icons.arrow_drop_down,
    initialValue,
    this.items,
    ValueChanged<T> onChanged,
    ValueSetter<T> onSaved,
    path,
    this.style,
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
  _InputDropDownState<T> createState() => _InputDropDownState<T>();
}

class _InputDropDownState<T> extends InputFieldState<T> {
  @override
  InputDropDown<T> get widget => super.widget;

  @override
  Widget build(BuildContext context) {
    return super.buildInputField(
      context,
      DropdownButton(
        elevation: 16,
        icon: Icon(widget.icon),
        iconSize: 24,
        items: widget.items,
        onChanged: isEnabled() ? (v) => super.didChange(v) : null,
        style: widget.style,
        value: value,
      ),
    );
  }
}
