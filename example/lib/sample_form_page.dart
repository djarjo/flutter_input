// Copyright 2020 Hajo.Lemcke@gmail.com
// Please see the LICENSE file for details.

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_input/flutter_input.dart';
import 'package:flutter_input_example/main.dart';

import 'sample_form_page.i18n.dart';
import 'sample_locale.dart';

/// Sample page with a form and input widgets from this package.
///
/// The input widgets are clustered into tab views.
/// The form allows to enable all fields at once (makes them editable)
/// and to abort or save the modified values back to the configuration.
class SampleFormPage extends StatefulWidget {
  @override
  _SampleFormPageState createState() => _SampleFormPageState();
}

class _SampleFormPageState extends State<SampleFormPage> {
  final GlobalKey<InputFormState> _formKey = GlobalKey();
  bool _inEditMode = false;
  void setInEditMode(bool editable) {
    setState(() {
      _inEditMode = editable;
      _formKey.currentState.enabled = editable;
    });
  }

  int coffeeTemp;
  List<String> selectableCountries = ['AU', 'DE', 'FR', 'JP', 'NL', 'SY', 'US'];
  List<DropdownMenuItem<String>> units;
  List<Tab> _titles = [];
  List<DropdownMenuItem<DateTimeUsing>> _dateTimeParts;
  DateTimeUsing _using = DateTimeUsing.dateAndTime;
  DatePickerStyles _datePickerStyles;

  @override
  void initState() {
    super.initState();
    // create your global calendar styles somewhere
    _datePickerStyles = DatePickerStyles(
      headerStyle: DatePickerStyle(
          decoration: BoxDecoration(color: Colors.deepOrangeAccent)),
    );
    _setupUnits();
    _titles = [
      Tab(text: 'Misc'.i18n),
      Tab(text: 'Text'),
      Tab(text: 'Date & Time'.i18n),
    ];
  }

  @override
  Widget build(BuildContext context) {
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
    List<Widget> _tabViews = [
      _buildViewMisc(context),
      _buildViewText(context),
      _buildViewDateTime(context),
    ];
    return DefaultTabController(
      length: _titles.length,
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SafeArea(
          minimum: EdgeInsets.all(5.0),
          child: InputForm(
            key: _formKey,
            enabled: _inEditMode, // to change see setInEditMode(true)
            map: centralData,
            child: TabBarView(children: _tabViews),
          ),
        ),
        drawer: _buildDrawer(context),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('flutter_input - Form'),
      actions: _inEditMode
          ? <Widget>[
              IconButton(
                icon: Icon(Icons.done),
                tooltip: 'Save changes and leave edit mode'.i18n,
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _save(context);
                  } else {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('Please correct validation errors'),
                      duration: Duration(seconds: 3),
                    ));

                    /// TODO use in next version Flutter > 1.22.4
/*                    ScaffoldMessengerState state =
                        ScaffoldMessenger.of(context);
                    state.showSnackBar(SnackBar(
                      content: Text('Please correct validation errors'),
                      duration: Duration(seconds: 3),
                      action: SnackBarAction(
                        label: 'dismiss',
                        onPressed: () => state.hideCurrentSnackBar(),
                      ),
                    ));
  */
                  }
                },
              ),
              IconButton(
                icon: Icon(Icons.cancel),
                tooltip: 'Exit without any changes'.i18n,
                onPressed: () {
                  setInEditMode(false);
                  _formKey.currentState.reset();
                },
              ),
            ]
          : <Widget>[
              IconButton(
                icon: Icon(Icons.edit),
                tooltip: 'Edit',
                onPressed: () => setInEditMode(true),
              )
            ],
      backgroundColor: Colors.deepOrange,
      bottom: TabBar(
        tabs: _titles,
        onTap: (index) => FocusScope.of(context).unfocus(),
      ),
    );
  }

  Widget _buildDataDisplay(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text('-- Central Data --'),
              Text(InputUtils.prettyPrintMap(centralData)),
              Text('-- Settings --'),
              Text(InputUtils.prettyPrintMap(sampleSettings)),
            ],
          ),
        ),
      ),
    );
  }

  /// Drawer sample usable in all pages
  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.language),
            title: Text('Select Language'.i18n),
            subtitle: InputLanguage(
              initialValue: SampleLocale().getThisAppsLocale(),
              onChanged: (locale) {
                SampleLocale().setThisAppsLocale(context, locale);
                Navigator.pop(context);
              },
              supportedLocales: SampleLocale.supportedLocales,
              withDeviceLocale: true,
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'.i18n),
            onTap: () {
              showDialog(
                context: context,
                child: _buildSettingsForm(context),
              ).then((value) {
                print('$value, settings=$sampleSettings');
                Navigator.of(context).pop(77);
              });
            },
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('Show data'),
            onTap: () {
              showDialog(
                context: context,
                child: _buildDataDisplay(context),
              ).then((value) {
                Navigator.of(context).pop(88);
              });
            },
          ),
          AboutListTile(
            icon: Icon(Icons.info),
            applicationLegalese: 'Free to Use',
            applicationName: 'flutter_input',
            applicationVersion: 'v1.4.0',
            aboutBoxChildren: <Widget>[
              Text('Thanks for using flutter_input!'.i18n),
            ],
          ),
        ],
      ),
    );
  }

  /// All input widgets in the settings form will NOT attach to
  /// an [InputForm] ancestor.
  Widget _buildSettingsForm(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              InputDatePicker(
                decoration: InputDecoration(labelText: 'Valid since'),
                map: sampleSettings,
                path: 'validSince',
              ),
              InputCheckbox(
                decoration: InputDecoration(labelText: 'Allow all'),
                map: sampleSettings,
                path: 'allowances',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildViewDateTime(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(children: <Widget>[
          InputDatePicker(
            decoration: InputDecoration(labelText: 'Birthday'),
            path: 'birthday',
            styles: _datePickerStyles,
            wantKeepAlive: true,
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
            decoration: InputDecoration(labelText: 'Somebodies birthday'.i18n),
            path: 'start',
          ),
        ]),
      ),
    );
  }

  Widget _buildViewMisc(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: <Widget>[
            Text('ID = ${centralData["id"]} | Localizations.locale '
                '= ${Localizations.localeOf(context)}'),
            Row(
              children: <Widget>[
                Flexible(
                  child: InputSwitch(
                    decoration: InputDecoration(
                      labelText: 'Author',
                    ),
                    path: 'author',
                    wantKeepAlive: true,
                  ),
                ),
                Flexible(
                  child: InputCheckbox(
                    decoration: InputDecoration(labelText: 'Active'),
                    path: 'active',
                  ),
                ),
              ],
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
                    '(${centralData["rateCount"]})',
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
                  labelText: 'Coffee Temperature'.i18n +
                      ' ${(coffeeTemp == null) ? "-"
                          "" : coffeeTemp}' +
                      ' °C'),
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
//              selectableCountries: selectableCountries,
              isExpanded: true,
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

  Widget _buildViewText(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(children: <Widget>[
          InputKeyboard<String>(
            decoration: InputDecoration(
              labelText: 'Name',
            ),
            path: 'name',
            validators: [
              (v) => minLength(v, 6, message: 'Not less than 6 chars')
            ],
            wantKeepAlive: true,
          ),
          InputKeyboard<int>(
            decoration: InputDecoration(labelText: 'Editable int'.i18n),
            path: 'editable int',
            validators: [(v) => min(v, 69, message: 'Not smaller than 69')],
          ),
          InputKeyboard<String>(
            decoration: InputDecoration(
              labelText: 'Login',
            ),
            path: 'login',
            validators: [(v) => notNull(v)],
          ),
          InputPassword(
            decoration: InputDecoration(
              labelText: 'Password',
            ),
            path: 'password',
            validators: [(v) => notNull(v)],
          ),
        ]),
      ),
    );
  }

  void _save(BuildContext context) {
    _formKey.currentState.save();
    setInEditMode(false);
    showDialog(
        context: context,
        barrierDismissible: false, // user must tap button
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Field values saved back to map'.i18n),
            content: SingleChildScrollView(
              child: Text(InputUtils.prettyPrintMap(centralData)),
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

  void _setupUnits() {
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
