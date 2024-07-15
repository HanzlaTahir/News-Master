// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
//
// class ThemeChanger with ChangeNotifier {
//   var _themeMode = ThemeMode.light;
//
//   ThemeMode get themeMode => _themeMode;
//
//   void setTheme(themeMode) {
//     _themeMode = _themeMode;
//     notifyListeners();
//   }
// }
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class ThemeChanger with ChangeNotifier {
//   late SharedPreferences storage;
//   var _themeMode = ThemeMode.light;
//
//   ThemeMode get themeMode => _themeMode;
//
//   void setTheme(ThemeMode themeMode) {
//     // Corrected parameter type
//     _themeMode = themeMode; // Corrected assignment
//     notifyListeners();
//   }
// }
// ************************************************************
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class ThemeChanger with ChangeNotifier {
//   ThemeMode _themeMode = ThemeMode.light;
//
//   ThemeMode get themeMode => _themeMode;
//
//   void initTheme(SharedPreferences prefs) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     _themeMode = prefs.getString('themeMode') == 'dark'
//         ? ThemeMode.dark
//         : ThemeMode.light;
//     notifyListeners();
//   }
//
//   void setTheme(ThemeMode themeMode) async {
//     _themeMode = themeMode;
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString(
//         'themeMode', themeMode == ThemeMode.dark ? 'dark' : 'light');
//     notifyListeners();
//   }
// }

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeChanger with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light; // Initial value

  ThemeMode get themeMode => _themeMode;

  // Initialize theme with saved preference or a default value
  Future<void> initTheme(SharedPreferences prefs) async {
    // Try to fetch the value from shared preferences
    String? storedThemeMode = prefs.getString('themeMode');

    // If found, convert from String to ThemeMode
    if (storedThemeMode != null) {
      _themeMode = storedThemeMode == 'dark' ? ThemeMode.dark : ThemeMode.light;
    } else {
      // If no saved preference, set to default (here, light)
      _themeMode = ThemeMode.light;
      await prefs.setString('themeMode', 'light');
    }

    notifyListeners();
  }
  // Save the new theme preference
  Future<void> setTheme(ThemeMode themeMode) async {
    _themeMode = themeMode;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'themeMode', themeMode == ThemeMode.dark ? 'dark' : 'light');
    notifyListeners();
  }
}
