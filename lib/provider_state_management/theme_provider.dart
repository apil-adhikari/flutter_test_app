import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/utils/constants.dart';

class ThemeProvider extends ChangeNotifier {
  // Initially, the theme of the app should be as same as of system.
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;
  bool get isLightMode => _themeMode == ThemeMode.light;
  bool get isSystemMode => _themeMode == ThemeMode.system;

  // Constructor:
  ThemeProvider() {
    _loadThemeFromPrefs();
  }

  // A seprate method, as it will be asynchronous when loading the data from the preferences.
  void _loadThemeFromPrefs() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final themeIndex = sharedPreferences.getInt(Constants.THEME_KEY) ?? 0;
      _themeMode = ThemeMode.values[themeIndex];
      notifyListeners();
    } catch (e) {
      _themeMode = ThemeMode.system;
    }
  }

  // A method to set the theme in the shared preferences:
  void _saveThemeToPrefs() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setInt(Constants.THEME_KEY, _themeMode.index);
    } catch (e) {
      print(e);
    }
  }

  // Method to toggle the theme:
  void setThemeMode(ThemeMode mode) {
    if (_themeMode != mode) {
      _themeMode = mode;
      _saveThemeToPrefs();
      notifyListeners();
    }
  }

  void toggleTheme() {
    if (_themeMode == ThemeMode.light) {
      setThemeMode(ThemeMode.dark);
    } else {
      setThemeMode(ThemeMode.light);
    }
  }

  void setLightMode() => setThemeMode(ThemeMode.light);
  void setDarkMode() => setThemeMode(ThemeMode.dark);
  void setSystemMode() => setThemeMode(ThemeMode.system);

  // Get the current theme Description:
  String get currentThemeDescription {
    switch (_themeMode) {
      case ThemeMode.light:
        return 'Light Mode';
      case ThemeMode.dark:
        return 'Dark Mode';
      case ThemeMode.system:
        return 'System Default';
    }
  }
}
