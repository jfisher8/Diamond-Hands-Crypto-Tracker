import 'package:diamond_hands_crypto_tracker/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeProvider() {
    getThemeOnBoot();
  }

  getThemeOnBoot() async {
    SharedPreferences darkModePreferences =
        await SharedPreferences.getInstance();
    bool? isDarkTheme = darkModePreferences.getBool('darkMode');
    if (isDarkTheme != null && isDarkTheme != false) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
    notifyListeners();
  }

  ThemeData _themeData = lightMode;

  bool get isDarkMode => themeData == darkMode;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme(bool isOn) async {
    themeData = isOn ? darkMode : lightMode;
    notifyListeners();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('darkMode', themeData == darkMode);
    if (_themeData == lightMode) {
      SharedPreferences darkModePreferences =
          await SharedPreferences.getInstance();
      await darkModePreferences.setBool('darkMode', true);
      themeData = darkMode;
    } else {
      SharedPreferences darkModePreferences =
          await SharedPreferences.getInstance();
      await darkModePreferences.setBool('darkMode', false);
      themeData = lightMode;
    }
  }
}
