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
    bool autosave,
    bool autovalidate,
    this.iconBackgroundColor,
    this.iconColor,
    this.iconBorder = Icons.favorite_border,
    this.iconFavorite = Icons.favorite,
    InputDecoration decoration,
    bool enabled,
    bool initialValue,
    Map<String, dynamic> map,
    ValueChanged<bool> onChanged,
    ValueSetter<bool> onSaved,
    String path,
    this.size = 23,
    List<InputValidator> validators,
    bool wantKeepAlive = false,
  }) : super(
          key: key,
          autosave: autosave,
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
  _InputFavoriteState createState() => _InputFavoriteState();
}

class _InputFavoriteState extends InputFieldState<bool> {
  @override
  InputFavorite get widget => super.widget;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return super.buildInputField(
      context,
      Align(
        alignment: Alignment.centerLeft,
        child: Tooltip(
          message: (value == null || value == false)
              ? 'Mark as favorite'
              : 'Remove favorite mark',
          child: GestureDetector(
            onTap: isEnabled() ? onPressedHandler : null,
            child: (value == null || value == false)
                ? Icon(widget.iconBorder,
                    color: widget.iconColor ?? Theme.of(context).primaryColor,
                    size: widget.size)
                : Icon(
                    widget.iconFavorite,
                    color: widget.iconColor ?? Theme.of(context).primaryColor,
                    size: widget.size,
                  ),
          ),
        ),
      ),
    );
  }

  void onPressedHandler() {
    if (value == null || value == false) {
      super.didChange(true);
    } else {
      super.didChange(false);
    }
  }
}
