// Copyright 2020 Hajo.Lemcke@mail.com
// Please see the LICENSE file for details.

import 'package:flutter/material.dart';

import 'input_form.dart';

/// Provides a spinner to set a value between [min] and [max].
///
/// Setting the value is performed by two buttons for decreasing and increasing the value.
/// The value will be changed with each click by `(max - min) / divisions`.
/// To have `value` of type int supply generic int.
class InputSpinner<T extends num> extends InputField<T> {
  final int divisions;
  final IconData iconDecrease;
  final Color iconDecreaseColor;
  final IconData iconIncrease;
  final Color iconIncreaseColor;
  final num interval;
  final num min, max;
  final double size;

  InputSpinner({
    Key key,
    bool autovalidate = false,
    this.divisions = 100,
    InputDecoration decoration,
    bool enabled,
    this.iconDecrease = Icons.remove_circle,
    this.iconDecreaseColor,
    this.iconIncrease = Icons.add_circle,
    this.iconIncreaseColor,
    T initialValue,
    this.min = 0.0,
    this.max = 100.0,
    ValueChanged<T> onChanged,
    ValueSetter<T> onSaved,
    String path,
    this.size = 25.0,
    List<InputValidator> validators,
  })  : assert(size != null),
        assert(min < max),
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
  _InputSpinnerState<T> createState() => _InputSpinnerState<T>();
}

class _InputSpinnerState<T extends num> extends InputFieldState<T> {
  @override
  InputSpinner<T> get widget => super.widget;
  TextEditingController controller;

  @override
  void initState() {
    super.initState();
    T curVal = _ensureMinMax(value);
    controller = TextEditingController(
      text: curVal.toString(),
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
            icon: Icon(
              widget.iconDecrease,
              color: widget.iconDecreaseColor,
            ),
            iconSize: widget.size,
          ),
          Container(
            child: TextField(
              controller: controller,
              enabled: super.isEnabled(),
              keyboardType: TextInputType.numberWithOptions(
                  signed: false, decimal: false),
              onChanged: super.isEnabled() ? (v) => textChanged(v) : null,
            ),
            width: 50,
          ),
          IconButton(
            onPressed: isEnabled() ? onPressedIncrease : null,
            icon: Icon(
              widget.iconIncrease,
              color: widget.iconIncreaseColor,
            ),
            iconSize: widget.size,
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
    T curVal = _ensureMinMax(value);
    curVal = curVal - widget.interval;
    curVal = _ensureMinMax(curVal);
    controller.text = curVal.toString();
    super.didChange(curVal);
  }

  void onPressedIncrease() {
    T curVal = _ensureMinMax(value);
    curVal = curVal + widget.interval;
    curVal = _ensureMinMax(curVal);
    controller.text = curVal.toString();
    super.didChange(curVal);
  }

  @override
  void reset() {
    super.reset();
    T curVal = _ensureMinMax(value);
    controller.text = curVal.toString();
  }

  void textChanged(String text) {
    num curVal;
    if (T == int) {
      curVal = int.tryParse(text);
    } else {
      curVal = double.tryParse(text);
    }
    curVal = _ensureMinMax(curVal);
    controller.text = curVal.toString();
    super.didChange(curVal);
  }

  /// Returns the most valid value
  num _ensureMinMax(num newValue) {
    if (newValue == null) {
      return widget.initialValue ?? (widget.max - widget.min) / 2;
    }
    if (newValue < widget.min) {
      return widget.min;
    }
    if (newValue > widget.max) {
      return widget.max;
    }
    return newValue;
  }
}
