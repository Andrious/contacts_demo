// ignore_for_file: avoid_positional_boolean_parameters

import 'dart:async' show Future;

import 'package:flutter/material.dart'
    show StatelessWidget, TextStyle, VoidCallback;

import 'package:contacts_demo/src/view.dart';

// ignore: avoid_classes_with_only_static_members
///
class Settings {
  ///
  static bool get(String? setting) {
    if (setting == null || setting.trim().isEmpty) {
      return false;
    }
    return Prefs.getBool(setting, false);
  }

  ///
  static Future<bool> set(String? setting, bool value) {
    if (setting == null || setting.trim().isEmpty) {
      return Future.value(false);
    }
    return Prefs.setBool(setting, value);
  }

  /// The order of items
  static bool order([bool? value]) {
    const setting = 'order_of_items';
    bool order;
    if (value == null) {
      order = Prefs.getBool(setting, false);
    } else {
      order = value;
      Prefs.setBool(setting, value);
    }
    return order;
  }

  /// Left-sided or right-sided interface
  static bool get onLeftSide => OnLeftSide().leftSided;

  ///
  static StatelessWidget tapText(String text, VoidCallback onTap,
          {TextStyle? style}) =>
      AppSettings.tapText(text, onTap, style: style);
}
