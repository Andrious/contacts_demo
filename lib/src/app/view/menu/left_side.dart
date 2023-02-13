import 'package:contacts_demo/src/view.dart';

///
class OnLeftSide {
  /// Only one instance is necessary
  factory OnLeftSide() => _this ??= OnLeftSide._();
  OnLeftSide._() {
    _sided = onLeftSide() ? 'Left' : 'Right';
  }
  static OnLeftSide? _this;

  /// 'On Left side' indicator
  bool get leftSided => _sided == 'Left';
  late String _sided;

  /// Left-sided interface or right-sided
  // ignore: avoid_positional_boolean_parameters
  bool onLeftSide([bool? value]) {
    const setting = 'left_sided';
    bool left;
    if (value == null) {
      left = Prefs.getBool(setting, false);
    } else {
      left = value;
      Prefs.setBool(setting, value);
    }
    return left;
  }

  /// 'On Left Side' switch
  Widget get onLeftSideSwitch =>
      // ignore: avoid_redundant_argument_values
      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        CupertinoSegmentedControl<String>(
          groupValue: _sided,
          onValueChanged: _leftSided,
          children: {
            'Left': L10n.t('  Left  '),
            'Right': L10n.t('  Right '),
          },
        ),
        L10n.t(
          'Sided',
        ),
      ]);

  /// Refresh the app's interface
  // ignore: avoid_positional_boolean_parameters
  void _leftSided(String value) {
    _sided = value;
    onLeftSide(value == 'Left');
    // Refresh the app's UI
    App.refresh();
  }

  /// Left-sided interface or right-sided
// ignore: avoid_positional_boolean_parameters
  void setLeftSide(bool? value) {
    if (value != null) {
      _leftSided(value ? 'Left' : 'Right');
    }
  }
}
