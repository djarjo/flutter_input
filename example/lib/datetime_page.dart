/// Sample page for DateTime input widgets.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_input/flutter_input.dart';
import 'package:flutter_input_example/main.dart';

import 'datetime_page.i18n.dart';

/// Example of some global configuration
const String cfgStart = 'start';
Map<String, dynamic> myAppConfig = {
  cfgStart: DateTime.parse('2020-02-29'),
};

///
class DateTimePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DateTimePageState();
}

class _DateTimePageState extends State<DateTimePage> {
  List<DropdownMenuItem<DateTimeUsing>> _dateTimeParts;
  DateTimeUsing _using = DateTimeUsing.dateAndTime;
  DatePickerStyles _datePickerStyles;
  DateTime _birthday;
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    // create your global calendar styles here
    _datePickerStyles = DatePickerStyles(
      headerStyle: DatePickerStyle(
          decoration: BoxDecoration(color: Colors.deepOrangeAccent)),
    );
    _dateTimeParts = [
      DropdownMenuItem<DateTimeUsing>(
        value: DateTimeUsing.dateOnly,
        child: Text('Date'.i18n),
      ),
      DropdownMenuItem<DateTimeUsing>(
        value: DateTimeUsing.timeOnly,
        child: Text('Time'.i18n),
      ),
      DropdownMenuItem<DateTimeUsing>(
        value: DateTimeUsing.dateAndTime,
        child: Text('Date & Time'.i18n),
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(context),
      appBar: AppBar(
        title: Text('DateTime Page'.i18n),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.keyboard_backspace),
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:'.i18n,
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            InputDatePicker(
              initialValue: _birthday ?? DateTime.parse('1977-02-17'),
              onChanged: (v) => setState(() {
                _birthday = v;
              }),
              styles: _datePickerStyles,
            ),
            InputRadio(
              // This input field is not attached to a form
              decoration: InputDecoration(
                  labelText: 'Date and time format selection'.i18n),
              direction: Axis.horizontal,
              initialValue: _using,
              items: _dateTimeParts,
              onChanged: (v) => setState(() {
                _using = v;
              }),
            ),
            InputDateTime(
              decoration: InputDecoration(labelText: 'Next Coffee Alarm'.i18n),
              path: 'alarm',
              using: _using,
            ),
            InputDate(
              decoration:
                  InputDecoration(labelText: 'Somebodies birthday'.i18n),
              path: cfgStart,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}