import 'package:contacts_demo/src/view.dart';

///
const String _sortKEY = 'sort_by_alpha';

/// Indicate if the records are sorted
bool get sortedAlpha => _sortedAlpha ??= Prefs.getBool(_sortKEY, false);

///
// ignore: avoid_positional_boolean_parameters
set sortedAlpha(bool? value) {
  if (value != null) {
    _sortedAlpha = value;
    Prefs.setBool(_sortKEY, value);
  }
}

bool? _sortedAlpha;
