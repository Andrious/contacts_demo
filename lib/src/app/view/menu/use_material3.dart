import 'package:contacts_demo/src/view.dart';

///
class UseMaterial3 {
  /// Only one instance is necessary
  factory UseMaterial3() => _this ??= UseMaterial3._();
  UseMaterial3._() {
    // Retrieve the current setting
    _useMaterial3 = Prefs.getBool('useMaterial3');
  }
  static UseMaterial3? _this;

  /// Return thr current setting
  bool get useMaterial3 => _useMaterial3;

  ///
  set useMaterial3(bool use) {
    if (_useMaterial3 != use) {
      _useMaterial3 = use;
      // Record
      Prefs.setBool('useMaterial3', use);
    }
  }

  late bool _useMaterial3;

  /// Supply a Switch widget
  Widget get useMaterial3Switch => Switch(
        value: _useMaterial3,
        onChanged: (v) => useMaterial3 = v,
      );

  /// Supply a ListTile widget
  // Wrapped by the Material widget in case this run in the Cupertino platform.
  Widget get useMaterial3ListTile => Material(
        child: ListTile(
          leading: Text('Use Material 3'.tr),
          trailing: useMaterial3Switch,
        ),
      );
}
