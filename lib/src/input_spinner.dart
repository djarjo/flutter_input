// Copyright 2020 Hajo.Lemcke@mail.com
// Please see the LICENSE file for details.

import 'package:flutter/material.dart';

import 'input_form.dart';

/// Provides a spinner to set a value between [min] and [max].
///
/// Setting the value is performed by two buttons for decreasing and increasing the value.
/// The value will be changed with each click by `(max - min) / divisions`.
/// To have `value` of type int supply generic int.
class InputSpinner extends InputField<double> {
  final int divisions;
  final Color iconColor;
  final IconData iconDecrease;
  final IconData iconIncrease;
  final double interval;
  final double min, max;
  final double size;

  InputSpinner({
    Key key,
    bool autovalidate = false,
    this.divisions = 100,
    InputDecoration decoration,
    bool enabled,
    this.iconColor,
    this.iconDecrease = Icons.remove_circle,
    this.iconIncrease = Icons.add_circle,
    double initialValue,
    this.min = 0,
    this.max = 100,
    ValueChanged<double> onChanged,
    ValueSetter<double> onSaved,
    String path,
    this.size,
    List<InputValidator> validators,
  })  : assert(min < max),
        assert(divisions != null),
        interval = (max - min) / divisions,
        super(
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
  _InputSpinnerState createState() => _InputSpinnerState();
}

class _InputSpinnerState extends InputFieldState<double> {
  @override
  InputSpinner get widget => super.widget;
  TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(
      text: (value ?? widget.initialValue ?? (widget.max - widget.min) / 2).toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return super.buildInputField(
      context,
      Row(
        children: <Widget>[
          IconButton(
            onPressed: isEnabled() ? onPressedDecrease : null,
            icon: Icon(widget.iconDecrease),
            iconSize: widget.size ?? 25,
          ),
          Container(
            child: TextField(
              controller: controller,
              enabled: super.isEnabled(),
              keyboardType:
                  TextInputType.numberWithOptions(signed: false, decimal: false),
              onChanged: super.isEnabled() ? (v) => textChanged(v) : null,
            ),
            width: 50,
          ),
          IconButton(
            onPressed: isEnabled() ? onPressedIncrease : null,
            icon: Icon(widget.iconIncrease),
            iconSize: widget.size ?? 25,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onPressedDecrease() {
    double curVal = value ?? widget.initialValue ?? (widget.max - widget.min) / 2;
    curVal = curVal - widget.interval;
    if (curVal < widget.min) {
      curVal = widget.min;
    }
    controller.text = curVal.toString();
    super.didChange(curVal);
  }

  void onPressedIncrease() {
    double curVal = value ?? widget.initialValue ?? (widget.max - widget.min) / 2;
    curVal = curVal + widget.interval;
    if (curVal > widget.max) {
      curVal = widget.max;
    }
    controller.text = curVal.toString();
    super.didChange(curVal);
  }

  void textChanged(String text) {
    double curVal = double.tryParse(text);
    curVal ??= widget.min;
    controller.text = curVal.toString();
    super.didChange(curVal);
  }
}
