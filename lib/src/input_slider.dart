// Copyright 2020 Hajo.Lemcke@mail.com
// Please see the LICENSE file for details.

import 'package:flutter/material.dart';
import 'package:flutter_input/flutter_input.dart';

import 'input_form.dart';

/// Provides a slider to select a value with type double between a given minimum and a given maximum.
class InputSlider extends InputField<double> {
  final Color activeColor, inactiveColor;
  final int divisions;
  final double min, max;

  InputSlider({
    Key key,
    this.activeColor,
    bool autovalidate = false,
    this.divisions,
    InputDecoration decoration,
    bool enabled,
    this.inactiveColor,
    double initialValue,
    Map<String, dynamic> map,
    this.min = 0.0,
    this.max = 100.0,
    ValueChanged<double> onChanged,
    ValueSetter<double> onSaved,
    String path,
    List<InputValidator> validators,
    bool wantKeepAlive = false,
  })  : assert(min < max),
        super(
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
  _InputSliderState createState() => _InputSliderState();
}

class _InputSliderState extends InputFieldState<double> {
  @override
  InputSlider get widget => super.widget;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return super.buildInputField(
      context,
      Slider.adaptive(
        activeColor: widget.activeColor,
        divisions: widget.divisions,
        inactiveColor: widget.inactiveColor,
        label: value?.floor().toString() ?? widget.min.toString(),
        min: widget.min,
        max: widget.max,
        onChanged: super.isEnabled() ? (v) => super.didChange(v) : null,
        value: value ?? widget.initialValue ?? widget.min,
      ),
    );
  }
}
