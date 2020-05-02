// Copyright 2020 Hajo.Lemcke@mail.com
// Please see the LICENSE file for details.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'input_form.dart';

/// Input widget for a date picker.
///
/// This is a thin wrapper around [showDatePicker]. See specific parameters there.
///
/// See [InputField] for common parameters.
class InputDate extends InputField<DateTime> {
  final DateTime firstDate, lastDate;
  final String datePattern;

  InputDate({
    Key key,
    bool autovalidate = false,
    this.datePattern = 'yyyy-MM-dd',
    InputDecoration decoration,
    bool enabled,
    this.firstDate,
    this.lastDate,
    DateTime initialValue,
    Map<String, dynamic> map,
    ValueChanged<DateTime> onChanged,
    ValueSetter<DateTime> onSaved,
    String path,
    List<InputValidator> validators,
    bool wantKeepAlive = false,
  })  : assert(datePattern != null),
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
  _InputDateState createState() => _InputDateState();
}

class _InputDateState extends InputFieldState<DateTime> {
  @override
  InputDate get widget => super.widget;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    DateTime displayDate = value ?? widget.initialValue ?? DateTime.now();
    String formattedDate = DateFormat(widget.datePattern).format(displayDate);
    return super.buildInputField(
      context,
      GestureDetector(
        child: Text(formattedDate),
        onTap: isEnabled()
            ? () async {
                DateTime dateTime = await showDatePicker(
                  context: context,
                  initialDate: displayDate,
                  firstDate: widget.firstDate ?? DateTime.parse('0001-01-01'),
                  lastDate: widget.lastDate ?? DateTime.parse('9999-12-31'),
                );
                didChange(dateTime);
              }
            : null,
      ),
    );
  }
}
