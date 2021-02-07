// Copyright 2020 Hajo.Lemcke@gmail.com
// Please see the LICENSE file for details.

import 'package:flutter/material.dart';

import 'country.dart';
import 'input_form.dart';

/// An input widget to select a country code from a sorted list of country names.
///
/// Displays flag and name of country with a trailing icon.
/// Selected value is two letter ISO-3166 code.
/// Flag display can be suppressed with `showFlag = false`.
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
  /// Cached list of translated countries
  List<DropdownMenuItem<String>> _countryList;

  //--- Checks changes to rebuild country list
  String _languageCode;

  @override
  InputCountry get widget => super.widget;

  @override
  Widget build(BuildContext context) {
    //--- Obtain currently active language
    Locale activeLocale = Localizations.maybeLocaleOf(context);
    String activeLangCode =
        (activeLocale == null) ? 'en' : activeLocale.languageCode;
    print(
        'activeLocale=$activeLocale active=$activeLangCode langCode=$_languageCode');
    //--- Check if list must be rebuilt
    if ((_countryList == null) ||
        (widget.selectableCountries != null) ||
        (_languageCode != activeLangCode)) {
      _languageCode = activeLangCode;
      _buildCountryList(_languageCode);
      print('${_countryList.length} countries');
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
                  Country.findByCode2(value)?.getTranslation(_languageCode) ??
                      '$value',
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

  void _buildCountryList(String langCode) {
    final String _imagePath = 'lib/assets/flags/';
    List<Country> countries = [];
    for (Country country in Country.values()) {
      if ((widget.selectableCountries != null) &&
          (widget.selectableCountries.contains(country.code2) == false)) {
        continue;
      }
      countries.add(country);
    }
    countries.sort((country1, country2) => country1
        .getTranslation(_languageCode)
        .compareTo(country2.getTranslation(_languageCode)));

    _countryList = countries
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
                    '  ' + country.getTranslation(_languageCode),
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
