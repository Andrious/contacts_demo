import 'package:contacts_demo/src/view.dart';

/// Deals with the Floating Action Button's offset
class OffsetPrefs {
  /// Must supply a Preference key
  OffsetPrefs(String? key) {
    if (key != null && key.isEmpty) {
      _prefKey = null;
    } else {
      _prefKey = key;
    }
  }
  String? _prefKey;

  ///
  Offset? get() {
    Offset? position;
    final offset = Prefs.getStringList(_prefKey);
    if (offset.isNotEmpty && offset[0].isNum) {
      position = Offset(double.parse(offset[0]), double.parse(offset[1]));
    }
    return position;
  }

  ///
  void set(DraggableDetails details) {
    final offset = <String>['${details.offset.dx}', '${details.offset.dy}'];
    Prefs.setStringList(_prefKey, offset);
  }
}
