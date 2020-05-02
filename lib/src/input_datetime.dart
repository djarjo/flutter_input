// Copyright 2020 Hajo.Lemcke@mail.com
// Please see the LICENSE file for details.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'date_helper.dart';
import 'input_form.dart';

/// An input widget for date and / or time.
///
/// The used part of a datetime value is set by providing an argument to [using]. Providing
/// `null` is the same as [DateTimeUsing.dateAndTime].
///
/// See [InputField] for common parameters.
///
/// TODO \[ \] internationalize widget.
class InputDateTime extends InputField<DateTime> {
  final DateTime firstDate, lastDate;
  final String datePattern, timePattern;
  final DateTimeUsing using;
  final CupertinoDatePickerMode mode;

  InputDateTime({
    Key key,
    bool autovalidate = false,
    this.datePattern = 'yyyy-MM-dd',
    InputDecoration decoration,
    bool enabled,
    this.firstDate,
    DateTime initialValue,
    this.lastDate,
    Map<String, dynamic> map,
    this.mode,
    ValueChanged<DateTime> onChanged,
    ValueSetter<DateTime> onSaved,
    String path,
    this.timePattern = 'HH:mm',
    this.using = DateTimeUsing.dateAndTime,
    List<InputValidator> validators,
    bool wantKeepAlive = false,
  })  : assert(datePattern != null),
        assert(timePattern != null),
        assert(using != null),
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
  _InputDateTimeState createState() => _InputDateTimeState();
}

class _InputDateTimeState extends InputFieldState<DateTime> {
  @override
  InputDateTime get widget => super.widget;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    CupertinoDatePickerMode cupertinoMode;
    if (widget.using == DateTimeUsing.dateOnly) {
      cupertinoMode = CupertinoDatePickerMode.date;
    } else if (widget.using == DateTimeUsing.timeOnly) {
      cupertinoMode = CupertinoDatePickerMode.time;
    } else {
      cupertinoMode = CupertinoDatePickerMode.dateAndTime;
    }
    DateTime displayValue = value ?? widget.initialValue ?? DateTime.now();
    List<Widget> dateTimeWidgets = _buildWidgets(displayValue);

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
                        initialDateTime: displayValue,
                        onDateTimeChanged: (v) => super.didChange(v),
                        use24hFormat: true,
                        mode: cupertinoMode,
                      ),
                    );
                  })
              : null,
        ));
  }

  List<Widget> _buildWidgets(DateTime displayValue) {
    String text;
    List<Widget> widgets = [];
    if (widget.using == null ||
        widget.using == DateTimeUsing.dateOnly ||
        widget.using == DateTimeUsing.dateAndTime) {
      text = DateFormat(widget.datePattern).format(displayValue);
      widgets.addAll([
        Icon(Icons.calendar_today),
        SizedBox(width: 5),
        Text(text),
      ]);
      if (widget.using == DateTimeUsing.dateAndTime) {
        widgets.add(SizedBox(
          width: 5,
        ));
      }
    }
    if (widget.using == DateTimeUsing.timeOnly ||
        widget.using == DateTimeUsing.dateAndTime) {
      text = DateFormat(widget.timePattern).format(displayValue);
      widgets.addAll([
        Icon(Icons.access_time),
        SizedBox(width: 5),
        Text(text),
      ]);
    }
    return widgets;
  }
}
