// Copyright 2020 Hajo.Lemcke@gmail.com
// Please see the LICENSE file for details.

import 'package:flutter/material.dart';

import 'country.dart';
import 'input_form.dart';

/// An input widget to select a country code from a sorted list of country names.
///
/// Displays a text with flag, name of currently selected country and a trailing icon.
/// Selected value is two letter ISO-3166 code.
/// Showing the flag can be suppressed with `showFlag = false`.
class InputCountry extends InputField<String> {
  InputCountry({
    Key key,
    bool autovalidate = false,
    InputDecoration decoration,
    bool enabled,
    this.icon,
    String initialValue,
    ValueChanged<String> onChanged,
    ValueSetter<String> onSaved,
    String path,
    this.selectableCountries,
    this.showFlag = true,
    List<InputValidator> validators,
    bool wantKeepAlive = false,
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
          wantKeepAlive: wantKeepAlive,
        );

  /// Displayed as dropdown icon.
  final Widget icon;

  /// List of ISO-3166 code-2 uppercase country codes which can be selected.
  /// Default `null` shows full list.
  final List<String> selectableCountries;

  /// `false` will not show the flag. Defaults to `true`.
  final bool showFlag;

  @override
  _InputCountryState createState() => _InputCountryState();
}

class _InputCountryState extends InputFieldState<String> {
  List<DropdownMenuItem<String>> _dropdownList;

  @override
  InputCountry get widget => super.widget;

  // List of countries will not be translated if in `initState()`.
  @override
  Widget build(BuildContext context) {
    super.build(context);
    _dropdownList = _buildDropdownList();
    return super.buildInputField(
      context,
      DropdownButton(
        icon: widget.icon ?? Icon(Icons.flag),
        items: _dropdownList,
        onChanged: (v) => super.didChange(v),
        value: value,
      ),
    );
  }

  List<DropdownMenuItem<String>> _buildDropdownList() {
    final String _imagePath = 'lib/assets/flags/';
    List<Country> countryList = [];
    for (Country country in Country.values()) {
      if ((widget.selectableCountries != null) &&
          (widget.selectableCountries.contains(country.code2) == false)) {
        continue;
      }
      countryList.add(country);
    }
    countryList.sort((country1, country2) =>
        country1.getLocalizedName().compareTo(country2.getLocalizedName()));

    return countryList
        .map((country) => DropdownMenuItem(
              value: country.code2,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  (widget.showFlag)
                      ? Image.asset(
                          _imagePath + country.code2 + '.png',
                          package: 'flutter_input',
                        )
                      : SizedBox(
                          width: 0,
                        ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(country.getLocalizedName()),
                ],
              ),
            ))
        .toList();
  }
}
