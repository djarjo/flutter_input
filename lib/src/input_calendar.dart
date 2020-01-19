///
import 'package:flutter/material.dart';
import 'package:flutter_input/flutter_input.dart';
import 'package:intl/intl.dart';

import 'date_helper.dart';

/// Provides an input widget for a date.
///
/// The date is displayed together with an icon. Tapping it opens a dialog box with
/// a date picker. The picker can be fully customized.
///
/// To have a date in the past, set [lastDate] to `DateTime.now()` or just add the validator
/// `validators: [(v) => past( v ),]`. Same with [firstDate].
///
/// TODO \[X\] year becomes TextField
/// TODO \[ \] Internationalize this input widget: day names, month names, tooltips, display format, first day of week
///
/// See [InputField] for all common parameters.
class InputCalendar extends InputField<DateTime> {
  /// Pattern to format the displayed date. Defaults to ISO 8601 'yyyy-MM-dd'.
  final String datePattern;

  /// The date picker will not go before [firstDate] if this is set and not after [lastDate]
  /// if this is set. Both values default to `null`.
  final DateTime firstDate, lastDate;
  final double size;

  /// Contains all the customizable styles for the date picker. See [CalendarStyles].
  final CalendarStyles styles;

  InputCalendar({
    Key key,
    bool autovalidate = false,
    this.datePattern = 'yyyy-MM-dd',
    InputDecoration decoration,
    bool enabled,
    this.firstDate,
    this.lastDate,
    DateTime initialValue,
    ValueChanged<DateTime> onChanged,
    ValueSetter<DateTime> onSaved,
    String path,
    this.size = 8 * kMinInteractiveDimension,
    this.styles,
    List<InputValidator> validators,
  })  : assert(size == null || size >= 8 * kMinInteractiveDimension),
        super(
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
  _InputCalendarState createState() => _InputCalendarState();
}

class _InputCalendarState extends InputFieldState<DateTime> {
  @override
  InputCalendar get widget => super.widget;

  @override
  Widget build(BuildContext context) {
    DateTime date = value ?? widget.initialValue ?? DateTime.now();
    return super.buildInputField(
      context,
      Container(
        child: GestureDetector(
          child: Row(
            children: <Widget>[
              Text('${DateFormat(widget.datePattern).format(date)}'),
              Icon(Icons.date_range),
            ],
          ),
          onTap: isEnabled()
              ? () async {
                  DateTime newDate = await showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                            child: _InputCalendarPicker(
                          baseWidget: widget,
                          initialDate: date,
                        ));
                      });
                  didChange(newDate);
                }
              : null,
        ),
      ),
    );
  }
}

/// The calendar picker is displayed in a dialog box. It can either be aborted or closed by
/// selecting today or any other day from the calendar grid.
class _InputCalendarPicker extends StatefulWidget {
  final InputCalendar baseWidget;
  final DateTime initialDate;

  _InputCalendarPicker({
    @required this.baseWidget,
    @required this.initialDate,
  });

  @override
  _InputCalendarPickerState createState() => _InputCalendarPickerState();
}

class _InputCalendarPickerState extends State<_InputCalendarPicker> {
  static final List<String> _monthNamesLong = [
    'January',
    'February',
    'March',
    'April',
    'Mai',
    'June',
    'Juli',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  final List<DropdownMenuItem<int>> _monthItems = [];

  // --- Displayed month and year
  int _month, _year;

  // --- used to analyze gestures
  double _dx, _dy;

  TextEditingController _yearController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _month = widget.initialDate.month;
    _year = widget.initialDate.year;
    for (int i = 0; i < _monthNamesLong.length; i++) {
      _monthItems.add(DropdownMenuItem<int>(
        child: Text(_monthNamesLong[i]),
        value: i + 1,
      ));
    }
  }

  /// Builds the calendar picker in a dialog overlay.
  @override
  Widget build(BuildContext context) {
    Widget tableHeader = _buildHeader(context);
    Table calendarTable = _buildTable(context);
    return Material(
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.greenAccent),
          ),
          height: 8 * kMinInteractiveDimension + 2,
          width: 8 * kMinInteractiveDimension,
          child: Column(
            children: <Widget>[
              tableHeader,
              GestureDetector(
                child: calendarTable,
                onHorizontalDragUpdate: (DragUpdateDetails details) {
                  _dx = details.delta.dx;
                },
                onHorizontalDragEnd: (DragEndDetails details) {
                  _setDisplayedMonth(delta: (_dx > 0) ? -1 : 1);
                },
                onVerticalDragUpdate: (details) {
                  _dy = details.delta.dy;
                },
                onVerticalDragEnd: (DragEndDetails details) {
                  _setDisplayedMonth(delta: (_dy > 0) ? -1 : 1);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void dispose() {
    if (_yearController != null) {
      _yearController.dispose();
    }
    super.dispose();
  }

  Widget _buildCell(String text, CalendarStyle style,
      {GestureTapCallback onTapHandler}) {
    Widget cell = Container(
      decoration: style?.decoration,
      height: kMinInteractiveDimension,
      child: Center(
        child: Text(
          text,
          style: style?.textStyle,
        ),
      ),
    );
    return (onTapHandler == null)
        ? cell
        : GestureDetector(
            child: cell,
            onTap: onTapHandler,
          );
  }

  // Builds the header of the calendar picker with close, previous month,
  // month and year, next month and today.
  Widget _buildHeader(BuildContext context) {
    Widget monthWidget = _buildMonthWidget();
    Widget yearWidget = _buildYearWidget();
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
              tooltip: 'Close without selection',
            ),
          ),
          Expanded(
            flex: 2,
            child: IconButton(
              icon: Icon(Icons.chevron_left),
              onPressed: () => _setDisplayedMonth(delta: -1),
              tooltip: 'Previous month',
            ),
          ),
          Expanded(
            flex: 6,
            child: monthWidget,
          ),
          Expanded(
            flex: 3,
            child: yearWidget,
          ),
          Expanded(
            flex: 2,
            child: IconButton(
              icon: Icon(Icons.chevron_right),
              onPressed: () => _setDisplayedMonth(delta: 1),
              tooltip: 'Next month',
            ),
          ),
          Expanded(
            flex: 2,
            child: IconButton(
              icon: Icon(Icons.today),
              onPressed: () => Navigator.of(context).pop(DateTime.now()),
              tooltip: 'Today',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthWidget() {
    return DropdownButton<int>(
      icon: null,
      iconSize: 0.0,
      items: _monthItems,
      value: _month,
      onChanged: (int v) {
        setState(() {
          _month = v;
        });
      },
    );
  }

  /// Adds one row to the table with week number and 7 day numbers
  TableRow _buildRow(DateTime date, CalendarStyle otherMonthStyle) {
    CalendarStyle dayStyle;
    int week = DateHelper.getWeekOfYear(date);
    List<Widget> cells = [];
    cells.add(_buildCell(
      '$week',
      widget.baseWidget.styles.weekStyle,
    ));
    for (int i = 0; i < 7; i++) {
      DateTime another = date;
      if (DateHelper.isBetween(
          first: widget.baseWidget.firstDate,
          last: widget.baseWidget.lastDate,
          date: another)) {
        if (DateHelper.isSameDay(date, DateTime.now())) {
          dayStyle = widget.baseWidget.styles.todayStyle;
        } else {
          dayStyle = (date.month == _month)
              ? widget.baseWidget.styles.monthStyle
              : otherMonthStyle;
        }
        cells.add(_buildCell('${date.day}', dayStyle, onTapHandler: () {
          Navigator.of(context).pop(another);
        }));
      } else {
        cells.add(Container());
      }
      date = date.add(Duration(days: 1));
    }
    return TableRow(children: cells);
  }

  /// Builds the calendar. It has a header row with column names and
  /// 6 rows with week number and the days of the selected month.
  Table _buildTable(BuildContext context) {
    List<TableRow> rows = [];

    //--- First row contains column headers
    List<Widget> tableCells = ['W', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su']
        .map((e) => _buildCell(e, widget.baseWidget.styles.headerStyle))
        .toList();
    rows.add(TableRow(children: tableCells));

    // --- Compute number of days from previous month
    DateTime displayMonth = DateTime(_year, _month, 1);
    DateTime displayDay =
        displayMonth.subtract(Duration(days: displayMonth.weekday - 1));
    rows.add(_buildRow(displayDay, widget.baseWidget.styles.prevMonthStyle));
    displayDay = displayDay.add(Duration(days: 7));
    for (int i = 1; i < 6; i++) {
      rows.add(_buildRow(displayDay, widget.baseWidget.styles.nextMonthStyle));
      displayDay = displayDay.add(Duration(days: 7));
    }
    return Table(
      children: rows,
    );
  }

  Widget _noCounterHandler(BuildContext context,
      {int currentLength, bool isFocused, int maxLength}) {
    return null;
  }

  Widget _buildYearWidget() {
    _yearController.text = '$_year';
    return TextField(
      buildCounter: _noCounterHandler,
      controller: _yearController,
      decoration: InputDecoration(border: InputBorder.none),
      enabled: true,
      keyboardType:
          TextInputType.numberWithOptions(signed: false, decimal: false),
      maxLength: 4,
      onSubmitted: (v) => _setDisplayedMonth(
        year: int.tryParse(v),
      ),
    );
  }

  /// Sets [year] and / or [month] or applies [delta] in months.
  ///
  /// Setting [delta] in number of months changes the year accordingly.
  /// Ensures that new month and year are within [InputCalendar.firstDate] and
  /// [InputCalendar.lastDate] if these are not null.
  void _setDisplayedMonth({int year, int month, int delta}) {
    setState(() {
      year ??= _year;
      month ??= _month;
      if (delta != null) {
        month = month + delta;
        while (month < 1) {
          month = month + 12;
          year--;
        }
        while (month > 12) {
          month = month - 12;
          year++;
        }
      }
      // Only set if within borders
      if (DateHelper.isBetween(
          first: widget.baseWidget.firstDate,
          last: widget.baseWidget.lastDate,
          year: year,
          month: month)) {
        _year = year;
        _month = month;
      }
//        WidgetsBinding.instance.addPostFrameCallback((_) async {
//          _monthWheelController.animateToItem(
//          _monthWheelController.jumpToItem( _month - 1 );
//        });
    });
  }
}

/// All styles for a calendar.
///
/// This class can be set once and then used for all calendars.
class CalendarStyles {
  /// Styles the first row of the picker which contains the column names.
  final CalendarStyle headerStyle,

      /// Styles the days in the currently selected month.
      monthStyle,

      /// Styles the days which are displyed from the next month.
      nextMonthStyle,

      /// Styles the days which are displyed from the previous month.
      prevMonthStyle,

      /// Styles today
      todayStyle,

      /// Styles the column which contains the number of the week
      weekStyle;

  const CalendarStyles({
    this.headerStyle = const CalendarStyle(
        decoration: BoxDecoration(color: Colors.amberAccent)),
    this.monthStyle =
        const CalendarStyle(textStyle: TextStyle(color: Colors.black)),
    this.nextMonthStyle =
        const CalendarStyle(textStyle: TextStyle(color: Colors.black38)),
    this.prevMonthStyle =
        const CalendarStyle(textStyle: TextStyle(color: Colors.black38)),
    this.todayStyle = const CalendarStyle(
        decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle)),
    this.weekStyle =
        const CalendarStyle(decoration: BoxDecoration(color: Colors.black12)),
  });
}

/// Styles for an [InputCalendar].
class CalendarStyle {
  final Decoration decoration;
  final TextStyle textStyle;

  const CalendarStyle({
    this.decoration,
    this.textStyle,
  });
}
