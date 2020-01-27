/// Flutter code sample for package `flutter_input`
///
/// ![Flutter Input sample](https://github.com/djarjo/flutter_input/sample.gif)
///
/// This app shows all available input fields within a form.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_input/flutter_input.dart';

import 'datetime_page.dart';

void main() {
  debugPaintSizeEnabled = false; // true does not work in web
  runApp(MyApp());
}

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'flutter_input Example';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: MyHomePage(_initializeData()),
      ),
    );
  }

  Map<String, dynamic> _initializeData() {
    return {
      'id': 666,
      'active': true,
      'amount': 123.45,
      'birthday': '1977-02-17',
      'title': 'Use InputKeyboard<String> instead',
      'rateCount': 4711,
      'rateValue': 71,
      // Nested map. Access with dotted path
      'myRating': {
        'favorite': true, // path = 'myRating.favorite'
        'value': 87, // path = 'myRating.value'
      },
    };
  }
}

class MyHomePage extends StatefulWidget {
  final Map<String, dynamic> data;
  MyHomePage(this.data, {Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<InputFormState> _formKey = GlobalKey();
  List<DropdownMenuItem<String>> countries;
  bool inEditMode = false;
  int coffeeTemp;

  @override
  Widget build(BuildContext context) {
//    print(widget.data);
    return Scaffold(
      appBar: AppBar(
        title: Text('Example Form'),
        actions: inEditMode
            ? <Widget>[
                IconButton(
                  icon: Icon(Icons.done),
                  tooltip: 'Save changes and leave edit mode',
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        _formKey.currentState.save();
                        inEditMode = false;
                        _formKey.currentState.enabled = false;
                      });
                      showDialog(
                          context: context,
                          barrierDismissible: false, // user must tap button
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Field values saved back to map'),
                              content: SingleChildScrollView(
                                child: Text(InputUtils.prettyPrintMap(widget.data)),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('Thanks'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          });
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.cancel),
                  tooltip: 'Exit without any changes',
                  onPressed: () {
                    setState(() {
                      inEditMode = false;
                      _formKey.currentState.enabled = false;
                      _formKey.currentState.reset();
                    });
                  },
                ),
              ]
            : <Widget>[
                IconButton(
                  icon: Icon(Icons.calendar_today),
                  tooltip: 'Switch to datetime page',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DateTimePage()),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  tooltip: 'Edit',
                  onPressed: () {
                    setState(() {
                      inEditMode = true;
                      _formKey.currentState.enabled = true;
                    });
                  },
                )
              ],
        backgroundColor: Colors.deepOrange,
      ),
      body: InputForm(
        key: _formKey,
        enabled: inEditMode,
        value: widget.data,
        child: ListView(
          padding: EdgeInsets.all(15.0),
          children: [
            Text('ID = ${widget.data["id"]}'),
            InputText(
              decoration: InputDecoration(
                labelText: '--- deprecated ---',
              ),
              path: 'title',
              validators: [(v) => minLength(v, 6, message: 'Not less than 6 chars')],
            ),
            InputKeyboard<int>(
              decoration: InputDecoration(labelText: 'Editable int'),
              path: 'editable int',
              validators: [(v) => min(v, 69, message: 'Not smaller than 69')],
            ),
            InputSwitch(
              decoration: InputDecoration(
                  labelText: 'Active', helperText: 'Helper text for InputSwitch "Active"'),
              path: 'active',
            ),
            InputCheckbox(
              decoration: InputDecoration(labelText: 'Local'),
              path: 'local',
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text('All users rating'),
                ),
                Expanded(
                  child: InputRating(
                    enabled: false,
                    path: 'rateValue',
                  ),
                ),
                Expanded(
                  child: Text(
                    '(${widget.data["rateCount"]})',
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: InputRating(
                    borderColor: Colors.grey,
                    color: Colors.orange,
                    decoration: InputDecoration(labelText: 'My Rating'),
                    path: 'myRating.value',
                  ),
                ),
                Expanded(
                  child: InputFavorite(
                    decoration: InputDecoration(labelText: 'My Favorite'),
                    path: 'myRating.favorite',
                  ),
                ),
              ],
            ),
            InputDropDown<String>(
              decoration: InputDecoration(
                  labelText: 'Country', hintText: '<Please select a country>'),
              items: countries,
              path: 'country',
              validators: [
                (v) => notNull(v, message: 'You must live somewhere'),
              ],
            ),
            InputSlider(
              decoration: InputDecoration(labelText: 'Coffee Temperatur $coffeeTemp °C'),
              divisions: 200,
              min: -50,
              max: 150,
              onChanged: (v) => setState(() {
                coffeeTemp = v?.floor();
              }),
              path: 'temperature',
              validators: [
                (v) => max(v, 101, message: 'This is only steam'),
                (v) => min(v, 0, message: 'This coffee is frozen'),
              ],
            ),
            InputSpinner(
              decoration: InputDecoration(labelText: 'Mug size [ml]'),
              path: 'size',
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    countries = [
      DropdownMenuItem<String>(
        value: 'CA',
        child: Text('Canada'),
      ),
      DropdownMenuItem<String>(
        value: 'DE',
        child: Text('Germany'),
      ),
      DropdownMenuItem<String>(
        value: 'FR',
        child: Text('France'),
      ),
      DropdownMenuItem<String>(
        value: 'JP',
        child: Text('Japan'),
      ),
    ];
  }
}
