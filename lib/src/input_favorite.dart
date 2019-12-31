// Copyright 2020 Hajo.Lemcke@mail.com
// Please see the LICENSE file for details.

import 'package:flutter/material.dart';

import 'input_form.dart';

/// Provides a favorite button to set a bool value.
/// The icons for a favorite or not can be set separately.
///
class InputFavorite extends InputField<bool> {
  final Color iconBackgroundColor, iconColor;
  final IconData iconFavorite, iconBorder;
  final double size;

  InputFavorite({
    Key key,
    bool autovalidate = false,
    this.iconBackgroundColor,
    this.iconColor,
    this.iconBorder = Icons.favorite_border,
    this.iconFavorite = Icons.favorite,
    InputDecoration decoration,
    bool enabled,
    bool initialValue,
    ValueChanged<bool> onChanged,
    ValueSetter<bool> onSaved,
    String path,
    this.size = 23,
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
  _InputFavoriteState createState() => _InputFavoriteState();
}

class _InputFavoriteState extends InputFieldState<bool> {
  @override
  InputFavorite get widget => super.widget;

  @override
  Widget build(BuildContext context) {
    return super.buildInputField(
      context,
      Tooltip(
        message: (value == null || value == true)
            ? 'Remove favorite mark'
            : 'Mark as favorite',
        child: GestureDetector(
          onTap: isEnabled() ? onPressedHandler : null,
          child: (value == null || value == true)
              ? Icon(
                  widget.iconFavorite,
                  color: widget.iconColor ?? Theme.of(context).primaryColor,
                  size: widget.size,
                )
              : Icon(widget.iconBorder,
                  color: widget.iconColor ?? Theme.of(context).primaryColor,
                  size: widget.size),
        ),
      ),
    );
  }

  void onPressedHandler() {
    if (value == null || value == true) {
      super.didChange(false);
    } else {
      super.didChange(true);
    }
  }
}
