// Copyright 2020 Hajo.Lemcke@gmail.com
// Please see the LICENSE file for details.

import 'package:flutter/material.dart';
import 'package:i18n_extension/i18n_widget.dart';

import 'country.dart';
import 'input_form.dart';

/// An input widget to select a country code from a sorted list of country names.
///
/// Displays a text with flag, name of currently selected country and a trailing icon.
/// Selected value is two letter ISO-3166 code.
/// Showing the flag can be suppressed with `showFlag = false`.
class InputCountry extends InputField<String> {
  final bool autofocus;
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
    this.autofocus = false,
    bool autosave,
    bool autovalidate,
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
  //--- Checks changes to rebuild country list
  String _languageCode;

  List<DropdownMenuItem<String>> _countryList;

  @override
  InputCountry get widget => super.widget;

  @override
  void initState() {
    _languageCode = I18n.language;
    super.initState();
  }

  // List of countries will not be translated if in `initState()`.
  @override
  Widget build(BuildContext context) {
    if (_countryList == null ||
        widget.selectableCountries != null ||
        _languageCode != I18n.language) {
      _countryList = _buildCountryList();
      _languageCode = I18n.language;
    }
    // super.build(context);
    return super.buildInputField(
      context,
      DropdownButton(
        autofocus: widget.autofocus,
        disabledHint: (value == null)
            ? null
            : ClipRect(
                child: Text(
                  Country.findByCode2(value)?.getLocalizedName() ?? '$value',
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),
              ),
        dropdownColor: widget.dropdownColor,
        elevation: widget.elevation ?? 8,
        focusColor: widget.focusColor,
        focusNode: widget.focusNode,
        hint: widget.hint,
        icon: widget.icon ??
            Icon((value == null) ? Icons.flag_outlined : Icons.arrow_drop_down),
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
        .map(
          (country) => DropdownMenuItem(
            value: country.code2,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                (widget.showFlag)
                    ? Image.asset(
                        _imagePath + country.code2 + '.png',
                        package: 'flutter_input',
                      )
                    : SizedBox.shrink(),
                Flexible(
                  child: Text(
                    '  ' + country.getLocalizedName(),
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                ),
              ],
            ),
          ),
        )
        .toList();
  }
}
