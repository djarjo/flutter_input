// Copyright 2020 Hajo.Lemcke@mail.com
// Please see the LICENSE file for details.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'input_form.dart';

enum InputDateFormat {
  /// Date format 24.12.2001
  dd_dot_MM_dot_yyyy,

  /// Corresponds to ISO 'yyyy-MM-dd' pattern
  ISO,

  /// US format
  MM_slash_dd_slash_yyyy,
}

enum InputDateWidget {
  Calendar,
  Sliver,
}

/// Provides an input field displaying a date.
/// If the field is enabled then tapping it will open a calendar to change the date.
class InputDate extends InputField<DateTime> {
  final DateTime firstDate, lastDate;
  final InputDateFormat dateFormat;

  InputDate({
    Key key,
    bool autovalidate = false,
    this.dateFormat,
    InputDecoration decoration,
    bool enabled,
    this.firstDate,
    this.lastDate,
    DateTime initialValue,
    ValueChanged<DateTime> onChanged,
    ValueSetter<DateTime> onSaved,
    String path,
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
  _InputDateState createState() => _InputDateState();
}

class _InputDateState extends InputFieldState<DateTime> {
  @override
  InputDate get widget => super.widget;

  @override
  Widget build(BuildContext context) {
    DateTime display = value ?? widget.initialValue ?? DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(display);
    return super.buildInputField(
      context,
      GestureDetector(
        child: Text(formattedDate),
        onTap: isEnabled()
            ? () async {
                DateTime dateTime = await showDatePicker(
                  context: context,
                  initialDate: display,
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
