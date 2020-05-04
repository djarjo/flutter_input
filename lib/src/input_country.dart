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
  final Color activeColor;
  final bool autofocus;
  final Color color;
  final Widget disabledHint;
  final Color dropdownColor;
  final int elevation;
  final Color focusColor;
  final FocusNode focusNode;
  final Widget hint;
  final Widget icon;
  final Color iconDisabledColor;
  final Color iconEnabledColor;
  final double iconSize;
  final bool isDense, isExpanded;
  final double itemHeight;
  final Function() onTap;

  /// List of ISO-3166 code-2 uppercase country codes which can be selected.
  /// Default `null` shows full list.
  final List<String> selectableCountries;

  final List<Widget> Function(BuildContext) selectedItemBuilder;

  /// `false` will not show the flag icon. Default is `true`.
  final bool showFlag;

  final TextStyle style;
  final Widget underline;

  InputCountry({
    Key key,
    this.activeColor,
    this.autofocus = false,
    bool autosave,
    bool autovalidate,
    this.color,
    InputDecoration decoration,
    this.disabledHint,
    this.dropdownColor,
    this.elevation,
    bool enabled,
    this.focusColor,
    this.focusNode,
    this.hint,
    this.icon,
    this.iconDisabledColor,
    this.iconEnabledColor,
    this.iconSize = 24.0,
    String initialValue,
    this.isDense = false,
    this.isExpanded = false,
    this.itemHeight = kMinInteractiveDimension,
    Map<String, dynamic> map,
    ValueChanged<String> onChanged,
    ValueSetter<String> onSaved,
    this.onTap,
    String path,
    this.selectableCountries,
    this.selectedItemBuilder,
    this.showFlag = true,
    this.style,
    this.underline,
    List<InputValidator> validators,
    bool wantKeepAlive = false,
  }) : super(
          key: key,
          autosave: autosave,
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
  _InputCountryState createState() => _InputCountryState();
}

class _InputCountryState extends InputFieldState<String> {
  List<DropdownMenuItem<String>> _countryList;

  @override
  InputCountry get widget => super.widget;

  // List of countries will not be translated if in `initState()`.
  @override
  Widget build(BuildContext context) {
    super.build(context);
    _countryList = _buildCountryList();
    return super.buildInputField(
      context,
      DropdownButton(
//        activeColor: widget.activeColor,
        autofocus: widget.autofocus,
//        color: widget.color,
        disabledHint: (value != null)
            ? _countryList.firstWhere((item) => value == item.value).child
            : null,
//        dropdownColor: widget.dropdownColor,
        elevation: widget.elevation ?? 8,
        focusColor: widget.focusColor,
        focusNode: widget.focusNode,
        hint: widget.hint,
        icon: widget.icon ?? Icon(Icons.flag),
        iconDisabledColor: widget.iconDisabledColor,
        iconEnabledColor: widget.iconEnabledColor,
        iconSize: widget.iconSize,
        isDense: widget.isDense,
        isExpanded: widget.isExpanded,
        items: _countryList,
        itemHeight: widget.itemHeight,
        onChanged: isEnabled() ? (v) => super.didChange(v) : null,
//        onTap: widget.onTap,
        selectedItemBuilder: widget.selectedItemBuilder,
        style: widget.style,
        underline: widget.underline,
        value: value,
      ),
    );
  }

  List<DropdownMenuItem<String>> _buildCountryList() {
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
