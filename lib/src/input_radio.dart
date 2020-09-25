// Copyright 2020 Hajo.Lemcke@mail.com
// Please see the LICENSE file for details.

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'input_form.dart';

/// Provides a group of radio buttons which can be aligned vertically (default)
/// or horizontally by setting parameter `direction`.
class InputRadio<T> extends InputField<T> {
  final Color activeColor;
//  final bool autofocus;
  final Color color;
  final Axis direction;
//  final Color focusColor;
//  final FocusNode focusNode;
  final Color hoverColor;
  final List<DropdownMenuItem<T>> items;
  final MaterialTapTargetSize materialTapTargetSize;
  final MouseCursor mouseCursor;
//  final bool toggleable;

  InputRadio({
    Key key,
    bool autovalidate = false,
    this.activeColor,
//    this.autofocus,
    this.color,
    InputDecoration decoration,
    this.direction = Axis.vertical,
    bool enabled,
    this.hoverColor,
    T initialValue,
    this.items,
    Map<String, dynamic> map,
    this.materialTapTargetSize,
    this.mouseCursor,
    ValueChanged<T> onChanged,
    ValueSetter<T> onSaved,
    String path,
//    this.toggleable,
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
          hoverColor: widget.hoverColor,
          label: item.child,
          materialTapTargetSize: widget.materialTapTargetSize,
          mouseCursor: widget.mouseCursor,
          icon: Radio(
            groupValue: value,
            onChanged: isEnabled() ? (v) => didChange(v) : null,
            value: item.value,
          ),
          onPressed: isEnabled() ? () => didChange(item.value) : null,
        );
      } else if (widget.direction == Axis.vertical) {
        return RadioListTile(
          groupValue: value,
          onChanged: isEnabled() ? (v) => didChange(v) : null,
          title: item.child,
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
