// Copyright 2020 Hajo.Lemcke@mail.com
// Please see the LICENSE file for details.

import 'package:flutter/material.dart';

import 'input_form.dart';

/// Provides a drop down button for a selection list
class InputDropdown<T> extends InputField<T> {
  final Color activeColor;
  final Color color;
  final int elevation;
  final IconData icon;
  final double iconSize;
  final List<DropdownMenuItem<T>> items;
  final TextStyle style;

  InputDropdown({
    Key key,
    bool autovalidate = false,
    this.activeColor,
    this.color,
    InputDecoration decoration,
    this.elevation,
    enabled,
    this.icon = Icons.arrow_drop_down,
    this.iconSize,
    initialValue,
    this.items,
    ValueChanged<T> onChanged,
    ValueSetter<T> onSaved,
    path,
    this.style,
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
  _InputDropdownState<T> createState() => _InputDropdownState<T>();
}

class _InputDropdownState<T> extends InputFieldState<T> {
  @override
  InputDropdown<T> get widget => super.widget;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return super.buildInputField(
      context,
      DropdownButton(
        elevation: widget.elevation ?? 8,
        disabledHint: value != null
            ? widget.items.firstWhere((item) => value == item.value).child
            : null,
        icon: Icon(widget.icon),
        iconSize: widget.iconSize ?? 24.0,
        items: widget.items,
        onChanged: isEnabled() ? (v) => super.didChange(v) : null,
        style: widget.style,
        value: value,
      ),
    );
  }
}
