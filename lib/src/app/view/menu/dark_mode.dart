import 'package:contacts_demo/src/view.dart';

/// Determine the app's dark mode.
class DarkMode {
  /// Only one instance
  factory DarkMode() => _this ??= DarkMode._();
  DarkMode._() {
    _isDarkMode = Prefs.getBool('darkmode', false);
  }
  static DarkMode? _this;

  /// Presented to the user
  Widget get darkModeListTile => _listTile();

  /// Supply a 'Dark Mode' Switch to a ListTile
  Widget get darkModeSwitch {
    final _switch = Switch(
      value: isDarkMode,
      onChanged: setDarkMode,
    );
    return _listTile(_switch);
  }

  // Wrapped by the Material widget in case this run in the Cupertino platform.
  Widget _listTile([Switch? _switch]) => Material(
        child: ListTile(
          leading: isDarkMode
              ? Image.asset(
                  'assets/images/moon.png',
                  height: 30,
                  width: 26,
                )
              : Image.asset(
                  'assets/images/sunny.png',
                  height: 30,
                  width: 26,
                ),
          title: L10n.t(isDarkMode ? 'to Light Mode' : 'to Dark Mode'),
          trailing: _switch,
        ),
      );

  /// Set the Dark Mode setting
  // ignore: avoid_positional_boolean_parameters
  void setDarkMode([bool? set]) {
    //
    if (set == null) {
      return;
    }

    if (set) {
      final theme = toDarkMode();
      App.themeData = theme;
      App.iOSTheme = theme;
    } else {
      isDarkMode = false;
      App.setThemeData();
    }

    // Refresh the app's UI
    App.refresh();
  }

  /// Indicate if in 'dark mode' or not
  bool get isDarkMode => _isDarkMode;
  late bool _isDarkMode;

  /// Record if the App's in dark mode or not.
  set isDarkMode(bool? set) {
    if (set == null) {
      return;
    }
    _isDarkMode = set;
    Prefs.setBool('darkmode', _isDarkMode);
  }

  /// Explicitly return the 'dark theme.'
  ThemeData toDarkMode() {
    isDarkMode = true;
    return ThemeData.dark();
  }

  /// Returns 'dark theme' only if specified.
  /// Otherwise, it returns null.
  ThemeData? setIfDarkMode() {
    ThemeData? data;

    if (!_isDarkMode) {
      data = null;
    } else {
      data = toDarkMode();
    }
    return data;
  }
}
