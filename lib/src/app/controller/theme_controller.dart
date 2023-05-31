import 'package:contacts_demo/src/controller.dart';

import 'package:contacts_demo/src/view.dart';

/// The App's theme controller
class ThemeController extends StateXController {
  ///
  factory ThemeController() => _this ??= ThemeController._();
  ThemeController._() {
    // The App's dark mode status
    _darkMode = DarkMode();
  }
  static ThemeController? _this;

  // Determine the app's dark mode.
  late DarkMode _darkMode;

  /// class ContactsField has TextStyle(fontSize: 24);

  /// Indicate if in 'dark mode' or not
  bool get isDarkMode => _darkMode.isDarkMode;

  /// Record if the App's in dark mode or not.
  set isDarkMode(bool? set) => _darkMode.isDarkMode = set;

  /// Explicitly return the 'dark theme.'
  ThemeData setDarkMode() => _darkMode.toDarkMode();

  /// Returns 'dark theme' only if specified.
  /// Otherwise, it returns null.
  ThemeData? setIfDarkMode() => _darkMode.setIfDarkMode();

  /// Tile to supply the app's dark mode or light mode.
  Widget get darkModeListTile => _darkMode.darkModeListTile;

  /// Toggle the current Dark Mode setting.
  bool switchDarkMode() {
    _darkMode.setDarkMode(!_darkMode.isDarkMode);
    return _darkMode.isDarkMode;
  }

  /// Supply the indicator
  bool get useMaterial3 => UseMaterial3().useMaterial3;

  /// Toggle the 'Use Material 3' setting
  void material3() {
    final use = UseMaterial3();
    use.useMaterial3 = !use.useMaterial3;
  }

  /// Tile to supply the app's 'Use Material 3' setting.
  Widget get useMaterial3ListTile => UseMaterial3().useMaterial3ListTile;

  /// Interface components on the left side or right side
  Widget get onLeftSideSwitch =>
      Text('${OnLeftSide().leftSided ? 'Left' : 'Right'} Sided'.tr);

  /// Toggle the current Dark Mode setting.
  bool switchInterfaceSides() {
    final onLeftSide = OnLeftSide();
    var leftSided = onLeftSide.leftSided;
    leftSided = !leftSided;
    onLeftSide.setLeftSide(leftSided);
    return leftSided;
  }
}
