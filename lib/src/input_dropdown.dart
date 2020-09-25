// Copyright 2020 Hajo.Lemcke@mail.com
// Please see the LICENSE file for details.

import 'package:flutter/material.dart';

import 'input_form.dart';

/// Provides a drop down button for a selection list
class InputDropdown<T> extends InputField<T> {
  final bool autofocus;
  final Widget disabledHint;
  final Color dropdownColor;
  final int elevation;
  final Color focusColor;
  final FocusNode focusNode;
  final Widget hint;
  final Widget icon;
  final Color iconDisabledColor;
  final Color iconEnabledColor;
  final double iconSize;
  final bool isDense, isExpanded;
  final double itemHeight;
  final List<DropdownMenuItem<T>> items;
  final Function() onTap;
  final List<Widget> Function(BuildContext) selectedItemBuilder;
  final TextStyle style;
  final Widget underline;
  final T value;

  InputDropdown({
    Key key,
    this.autofocus = false,
    bool autosave,
    bool autovalidate,
    InputDecoration decoration,
    this.disabledHint,
    this.dropdownColor,
    this.elevation,
    enabled,
    this.focusColor,
    this.focusNode,
    this.hint,
    this.icon,
    this.iconDisabledColor,
    this.iconEnabledColor,
    this.iconSize = 24.0,
    initialValue,
    this.isDense = false,
    this.isExpanded = false,
    this.itemHeight = kMinInteractiveDimension,
    this.items,
    Map<String, dynamic> map,
    ValueChanged<T> onChanged,
    ValueSetter<T> onSaved,
    this.onTap,
    path,
    this.selectedItemBuilder,
    this.style,
    this.underline,
    List<InputValidator> validators,
    this.value,
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
        autofocus: widget.autofocus,
        disabledHint: widget.disabledHint ?? (value != null)
            ? widget.items.firstWhere((item) => value == item.value).child
            : null,
        elevation: widget.elevation ?? 8,
        focusColor: widget.focusColor,
        focusNode: widget.focusNode,
        hint: widget.hint,
        icon: widget.icon,
        iconDisabledColor: widget.iconDisabledColor,
        iconEnabledColor: widget.iconEnabledColor,
        iconSize: widget.iconSize,
        isDense: widget.isDense,
        isExpanded: widget.isExpanded,
        items: widget.items,
        itemHeight: widget.itemHeight,
        onChanged: isEnabled() ? (v) => super.didChange(v) : null,
        onTap: widget.onTap,
        selectedItemBuilder: widget.selectedItemBuilder,
        style: widget.style,
        underline: widget.underline,
        value: value,
      ),
    );
  }
}
