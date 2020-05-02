// Copyright 2020 Hajo.Lemcke@mail.com
// Please see the LICENSE file for details.

import 'package:flutter/material.dart';

import 'input_form.dart';

/// Provides a horizontal rating displaying empty, half and full icons.
/// This 3 icons can be given as parameters. They default to stars.
/// The rating value can be set with parameters min (default = 0),
/// max (default = 100) and initialValue (default = 1).
///
/// Rating manipulation can be disabled. Set `enable = false` to display only current value.
class InputRating extends InputField<double> {
  final Color borderColor;
  final Color color;
  final int iconCount;
  final IconData iconEmpty, iconHalf, iconFull;
  final double min, max;
  final double size;

  InputRating({
    Key key,
    bool autovalidate = false,
    this.borderColor,
    this.color,
    InputDecoration decoration,
    bool enabled,
    this.iconCount = 5,
    Widget iconEmpty,
    Widget iconFull,
    Widget iconHalf,
    double initialValue,
    Map<String, dynamic> map,
    this.min = 0.0,
    this.max = 100.0,
    ValueChanged<double> onChanged,
    ValueSetter<double> onSaved,
    String path,
    this.size = 25.0,
    List<InputValidator> validators,
    bool wantKeepAlive = false,
  })  : assert(min < max),
        iconEmpty = iconEmpty ?? Icons.star_border,
        iconHalf = iconHalf ?? Icons.star_half,
        iconFull = iconFull ?? Icons.star,
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
  _InputRatingState createState() => _InputRatingState();
}

class _InputRatingState extends InputFieldState<double> {
//  static const double _allInsets = 10.0;
  double _starSize;

  @override
  InputRating get widget => super.widget;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _starSize ??=
        widget.size ?? MediaQuery.of(context).size.width / widget.iconCount;

    return super.buildInputField(
      context,
      Material(
        type: MaterialType.transparency,
        child: Center(
            child: Container(
          height: _starSize * 1.1,
//        margin: const EdgeInsets.all(_allInsets),
          child: Stack(
            children: <Widget>[
              Positioned(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(
                    widget.iconCount,
                    (index) => _buildStar(context, index),
                  ),
                ),
                top: 0.0,
                width: _starSize * widget.iconCount,
                left: 0.0,
                height: _starSize,
              ),
              (super.isEnabled())
                  ? Positioned(
                      child: SliderTheme(
                        child: Slider(
                          inactiveColor: Colors.transparent,
                          label: value?.floor().toString() ??
                              widget.min.toString(),
                          min: widget.min,
                          max: widget.max,
                          onChanged: (v) => super.didChange(v),
                          value: value ?? (widget.min + 0.0012345),
                        ),
                        data: SliderThemeData(
                          activeTrackColor: Colors.transparent,
                          overlayShape: RoundSliderOverlayShape(
                              overlayRadius: _starSize / 2),
                          showValueIndicator: ShowValueIndicator.always,
                          thumbColor: Colors.transparent,
                          valueIndicatorColor: Colors.greenAccent,
                        ),
                      ),
                      top: _starSize / 4,
                      width: _starSize * widget.iconCount,
                      left: 0.0,
                      height: _starSize * 0.6,
                    )
                  : Container(),
            ],
          ),
        )),
      ),
    );
  }

  Widget _buildStar(BuildContext context, int index) {
    double delta = widget.max - widget.min;
    double interval = delta / widget.iconCount;
    double sliderVal = value ?? (widget.min + 0.0012345);
    if (sliderVal >= (index + 1) * interval) {
      return Icon(widget.iconFull,
          color: widget.color ?? Theme.of(context).primaryColor,
          size: _starSize);
    } else if (sliderVal >= (index * interval) + (interval / 2)) {
      return Icon(widget.iconHalf,
          color: widget.color ?? Theme.of(context).primaryColor,
          size: _starSize);
    }
    return Icon(widget.iconEmpty,
        color: widget.borderColor ?? Theme.of(context).buttonColor,
        size: _starSize);
  }
}
