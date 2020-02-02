// Copyright 2020 Hajo.Lemcke@gmail.com
// Please see the LICENSE file for details.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_input/flutter_input.dart';
import 'package:flutter_input_example/main.dart';

import 'datetime_page.dart';
import 'form_page.i18n.dart';

/// Sample page with a form and some input widgets.
///
/// This page uses the central drawer and provides a form with fields to manipulate
/// a central configuration. The form allows to enable all fields at once
/// (makes them editable) and to abort
/// or save the modified values back to the configuration.
class SampleFormPage extends StatefulWidget {
  @override
  _SampleFormPageState createState() => _SampleFormPageState();
}

class _SampleFormPageState extends State<SampleFormPage> {
  List<String> selectableCountries = ['AU', 'DE', 'FR', 'JP', 'NL', 'US'];
  final GlobalKey<InputFormState> _formKey = GlobalKey();
  List<DropdownMenuItem<String>> units;
  bool inEditMode = false;
  int coffeeTemp;

  @override
  Widget build(BuildContext context) {
//    print(widget.data);
    return Scaffold(
      drawer: buildDrawer(context),
      appBar: AppBar(
        title: Text('flutter_input - Form'),
        actions: inEditMode
            ? <Widget>[
                IconButton(
                  icon: Icon(Icons.done),
                  tooltip: 'Save changes and leave edit mode'.i18n,
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
                              title:
                                  Text('Field values saved back to map'.i18n),
                              content: SingleChildScrollView(
                                child:
                                    Text(InputUtils.prettyPrintMap(sampleData)),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('Thanks'.i18n),
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
                  tooltip: 'Exit without any changes'.i18n,
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
                  tooltip: 'Switch to datetime page'.i18n,
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
        decoration: InputDecoration(
//          border: OutlineInputBorder(), // Activate this to see field borders
          contentPadding: EdgeInsets.only(
            bottom: 5.0,
            top: 5.0,
          ),
        ),
        key: _formKey,
        enabled: inEditMode,
        value: sampleData,
        child: ListView(
          padding: EdgeInsets.all(10.0),
          children: [
            Text(
                'ID = ${sampleData["id"]} // Flutter locale = ${Localizations.localeOf(context)}'),
            InputKeyboard<String>(
              decoration: InputDecoration(
                labelText: 'Name',
              ),
              path: 'name',
              validators: [
                (v) => minLength(v, 6, message: 'Not less than 6 chars')
              ],
            ),
            InputKeyboard<int>(
              decoration: InputDecoration(labelText: 'Editable int'.i18n),
              path: 'editable int',
              validators: [(v) => min(v, 69, message: 'Not smaller than 69')],
            ),
            InputSwitch(
              decoration: InputDecoration(
                labelText: 'Author',
              ),
              path: 'author',
            ),
            InputCheckbox(
              decoration: InputDecoration(labelText: 'Active'),
              path: 'active',
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text('All users rating'.i18n),
                ),
                Expanded(
                  child: InputRating(
                    enabled: false,
                    path: 'rateValue',
                  ),
                ),
                Expanded(
                  child: Text(
                    '(${sampleData["rateCount"]})',
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
            InputSlider(
              decoration: InputDecoration(
                  labelText:
                      'Coffee Temperatur ${(coffeeTemp == null) ? "-" : coffeeTemp} °C'),
              divisions: 200,
              min: -50,
              max: 150,
              onChanged: (v) => setState(() {
                coffeeTemp = v?.floor();
              }),
              path: 'temperature',
              validators: [
                (v) => max(v, 101, message: 'This is only steam'.i18n),
                (v) => min(v, 0, message: 'This coffee is frozen'.i18n),
              ],
            ),
            InputSpinner(
              decoration: InputDecoration(labelText: 'Mug size [ml]'.i18n),
              path: 'size',
            ),
            InputDropdown<String>(
              decoration: InputDecoration(
                  labelText: 'Unit'.i18n,
                  hintText: '<Please select the SI unit>'.i18n),
              items: units,
              path: 'unit',
            ),
            InputCountry(
              decoration: InputDecoration(
                  labelText: 'Country'.i18n,
                  hintText: '<Please select a country>'.i18n),
              selectableCountries: selectableCountries,
              path: 'country',
              validators: [
                (v) => notNull(v, message: 'You must live somewhere'.i18n),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    units = [
      DropdownMenuItem<String>(
        value: 'A',
        child: Text('Ampere'),
      ),
      DropdownMenuItem<String>(
        value: 'cd',
        child: Text('Candela'),
      ),
      DropdownMenuItem<String>(
        value: 'K',
        child: Text('Kelvin'),
      ),
      DropdownMenuItem<String>(
        value: 'kg',
        child: Text('Kilogram'),
      ),
      DropdownMenuItem<String>(
        value: 'm',
        child: Text('Meter'),
      ),
      DropdownMenuItem<String>(
        value: 'mol',
        child: Text('Mol'),
      ),
      DropdownMenuItem<String>(
        value: 's',
        child: Text('Second'),
      ),
    ];
  }
}
