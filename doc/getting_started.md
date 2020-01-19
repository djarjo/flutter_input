# Get started with _flutter_input_

Just add the package to file _'pubspec.yaml'_ in section _dependencies_.

```yaml
dependencies:
  flutter:  
      flutter_input: ^0.2.0    
```

For a complete example see [example/lib/main.dart]

## Use input widgets standalone

To use any input widget without a form, instantiate it
and provide an _initialValue_ and an _onChanged()_ method.

```dart
int sliderValue = 7;

InputSlider(
  initialValue: sliderValue,
  onChanged: (v) =>  {
    setState(() {
      sliderValue = v;
    });
  },
  );
```

## Use input widgets within a form

To use input widgets within a form, it must be a descendant of
_InputForm_ AND parameter _path_ must be set.

If 