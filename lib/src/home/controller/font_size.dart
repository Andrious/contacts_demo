import 'package:contacts_demo/src/view.dart';

///
const String _sizeKey = 'font_size';

/// Indicate if the records are sorted
double? get fontSize {
  // Turn to System Preferences for a saved font size
  if (_fontSize == null) {
    _fontSize = Prefs.getDouble(_sizeKey);
    if (_fontSize == 0) {
      // Can't be of a zero size. Return null.
      _fontSize = null;
    }
  }
  return _fontSize;
}

///
// ignore: avoid_positional_boolean_parameters
set fontSize(double? value) {
  if (value != null) {
    if (value == 0) {
      value = _appFontSize;
    }
    _fontSize = value;
    Prefs.setDouble(_sizeKey, _fontSize);
  }
}

double? _fontSize;

/// Increase the current font size
void addFontSize() => fontSize = _thisFontSize + 1;

/// Reduce the current font size.
void subFontSize() => fontSize = _thisFontSize - 1;

/// The current font size
double get _thisFontSize => fontSize ?? _appFontSize;

/// The app's default font size.
double get _appFontSize =>
    App.themeData!.textTheme.displayMedium!.fontSize ?? 24;
