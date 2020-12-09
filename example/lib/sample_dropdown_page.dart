import 'package:flutter/material.dart';
import 'package:flutter_input/flutter_input.dart';

class SampleDrowdownPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SampleDropdownPageState();
}

class SampleDropdownPageState extends State<SampleDrowdownPage> {
  String countryCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dropdown Samples'),
      ),
      body: SafeArea(
        minimum: EdgeInsets.all(5.0),
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text('Nationality'),
          InputCountry(
            decoration: InputDecoration(
                labelText: 'Country', hintText: '<Please select a country>'),
//              selectableCountries: selectableCountries,
            initialValue: countryCode,
            onChanged: (newVal) => setState(() => countryCode = newVal),
            path: 'country',
            validators: [
              (v) => notNull(v, message: 'You must live somewhere'),
            ],
          ),
        ],
      ),
    );
  }
}
