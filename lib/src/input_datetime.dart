// Copyright 2020 Hajo.Lemcke@mail.com
// Please see the LICENSE file for details.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'input_form.dart';

enum InputDateTimeFormat {
  /// Date format 24.12.2001
  dd_dot_MM_dot_yyyy,

  /// Corresponds to the ICU 'HH:mm' pattern.
  ///
  /// This format uses 24-hour two-digit zero-padded hours. Controls are always
  /// laid out horizontally. Hours are separated from minutes by one colon
  /// character.
  HH_colon_mm,

  /// Corresponds to ISO ??? 'yyyy-MM-dd HH:mm' pattern
  ISO,

  /// US format
  MM_slash_dd_slash_yyyy,

  /// ISO date format 2001-12-24
  yyyy_dash_MM_dash_dd,
}

/// Provides an input for date and / or time.
///
/// The displayed value depends on [InputDateTimeFormat] which is
/// Current value will be displayed as a text with leading icon and trailing text "set".
/// Tapping on this container will open a dialog box with spinning pickers for each
/// part of the date and time.
class InputDateTime extends InputField<DateTime> {
  final DateTime firstDate, lastDate;
  final InputDateTimeFormat format;

  InputDateTime({
    Key key,
    bool autovalidate = false,
    InputDecoration decoration,
    bool enabled,
    this.firstDate,
    this.format = InputDateTimeFormat.ISO,
    DateTime initialValue,
    this.lastDate,
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
  _InputDateTimeState createState() => _InputDateTimeState();

  static bool hasDate(InputDateTimeFormat format) {
    switch (format) {
      case InputDateTimeFormat.dd_dot_MM_dot_yyyy:
        return true;
      case InputDateTimeFormat.HH_colon_mm:
        return false;
      case InputDateTimeFormat.ISO:
        return true;
      case InputDateTimeFormat.MM_slash_dd_slash_yyyy:
        return true;
      case InputDateTimeFormat.yyyy_dash_MM_dash_dd:
        return true;
    }
  }
}

class _InputDateTimeState extends InputFieldState<DateTime> {
  @override
  InputDateTime get widget => super.widget;

  @override
  Widget build(BuildContext context) {
    DateTime display = value ?? widget.initialValue ?? DateTime.now();
    CupertinoDatePickerMode mode;
    List<Widget> dateWidgets = _formatDate(widget.format, display);
    List<Widget> timeWidgets = _formatTime(widget.format, display);
    List<Widget> dateTimeWidgets = [];

    if (dateWidgets == null) {
      mode = CupertinoDatePickerMode.time;
    } else {
      mode = (timeWidgets == null)
          ? CupertinoDatePickerMode.date
          : CupertinoDatePickerMode.dateAndTime;
      dateTimeWidgets.addAll(dateWidgets);
    }
    if (timeWidgets != null) {
      dateTimeWidgets.add(SizedBox(width: 25));
      dateTimeWidgets.addAll(timeWidgets);
    }

    return super.buildInputField(
        context,
        FlatButton(
          child: Row(
            children: dateTimeWidgets,
          ),
          onPressed: isEnabled()
              ? () => showModalBottomSheet(
                  context: context,
                  builder: (BuildContext builder) {
                    return Container(
                      height: MediaQuery.of(context).copyWith().size.height / 3,
                      child: CupertinoDatePicker(
                        initialDateTime: display,
                        onDateTimeChanged: (v) => super.didChange(v),
                        use24hFormat: true,
                        mode: mode,
                      ),
                    );
                  })
              : null,
        ));
  }

  List<Widget> _formatDate(InputDateTimeFormat format, DateTime dateTime) {
    if (dateTime == null) {
      return null;
    }
    String text;
    if (format == InputDateTimeFormat.ISO ||
        format == InputDateTimeFormat.yyyy_dash_MM_dash_dd) {
      text = DateFormat('yyyy-MM-dd').format(dateTime);
    } else if (format == InputDateTimeFormat.dd_dot_MM_dot_yyyy) {
      text = DateFormat('dd.MM.yyyy').format(dateTime);
    } else if (format == InputDateTimeFormat.MM_slash_dd_slash_yyyy) {
      text = DateFormat('MM/dd/yyyy').format(dateTime);
    } else {
      return null;
    }
    return [
      Icon(Icons.calendar_today),
      SizedBox(width: 5),
      Text(text),
    ];
  }

  List<Widget> _formatTime(InputDateTimeFormat format, DateTime dateTime) {
    if (dateTime == null) {
      return null;
    }
    String text;
    if (format == InputDateTimeFormat.ISO || format == InputDateTimeFormat.HH_colon_mm) {
      text = DateFormat('HH:mm').format(dateTime);
    } else {
      return null;
    }
    return [
      Icon(Icons.access_time),
      SizedBox(width: 5),
      Text(text),
    ];
  }
}
