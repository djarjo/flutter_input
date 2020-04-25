// Copyright 2020 Hajo.Lemcke@mail.com
// Please see the LICENSE file for details.

import 'package:flutter/material.dart';

import 'input_form.dart';

/// Provides a group of radio buttons which can be aligned vertically (default)
/// or horizontally.
class InputRadio<T> extends InputField<T> {
  final Color activeColor;
  final Color color;
  final Axis direction;
  final List<DropdownMenuItem<T>> items;

  InputRadio({
    Key key,
    bool autovalidate = false,
    this.activeColor,
    this.color,
    InputDecoration decoration,
    this.direction = Axis.vertical,
    bool enabled,
    T initialValue,
    this.items,
    ValueChanged<T> onChanged,
    ValueSetter<T> onSaved,
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
  _InputRadioState<T> createState() => _InputRadioState<T>();
}

class _InputRadioState<T> extends InputFieldState<T> {
  @override
  InputRadio<T> get widget => super.widget;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    value ??= widget.items[0].value;
    List<Widget> radioButtonList = widget.items.map((item) {
      if (widget.direction == Axis.horizontal) {
        return FlatButton.icon(
          label: item.child,
          icon: Radio(
            value: item.value,
            groupValue: value,
            onChanged: isEnabled() ? (v) => didChange(v) : null,
          ),
          onPressed: isEnabled() ? () => didChange(item.value) : null,
        );
      } else if (widget.direction == Axis.vertical) {
        return RadioListTile(
          title: item.child,
          groupValue: value,
          onChanged: isEnabled() ? (v) => didChange(v) : null,
          value: item.value,
        );
      } else {
        throw UnimplementedError('Unsupported widget direction <' +
            widget.direction.toString() +
            '>');
      }
    }).toList();

    Widget radioButtonWidget;
    if (widget.direction == Axis.horizontal) {
      radioButtonWidget = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: radioButtonList,
      );
    } else if (widget.direction == Axis.vertical) {
      radioButtonWidget = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: radioButtonList,
      );
    } else {
      throw UnimplementedError(
          'Unsupported widget direction <' + widget.direction.toString() + '>');
    }

    return SingleChildScrollView(
      scrollDirection: widget.direction,
      child: radioButtonWidget,
    );
  }
}
