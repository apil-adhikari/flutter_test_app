import 'package:flutter/material.dart';

class ThemeChangerProvider extends ChangeNotifier {
  bool _isSystemTheme = true;
  bool get systemTheme => _isSystemTheme;
  // Initially set the theme to the system mode:
  ThemeMode _currentTheme = ThemeMode.light;
  ThemeMode get currentTheme => _currentTheme;

  // void useSystemTheme(dynamic themeMode) {
  //   _systemTheme = themeMode == ThemeMode.system ? true : false;
  //   _currentTheme = themeMode == ThemeMode.system
  //       ? ThemeMode.system
  //       : currentTheme;
  //   notifyListeners();
  // }

  // Toggling the system theme:
  void useSystemTheme(bool useSystemTheme) {
    _currentTheme = useSystemTheme ? ThemeMode.system : ThemeMode.light;

    _isSystemTheme = useSystemTheme ? true : false;
    // true -> false:
    notifyListeners();
  }

  // Function to toggle theme:
  void toggleTheme(dynamic themeMode) {
    // this function can accept either dart or light mode
    _currentTheme = themeMode;
    notifyListeners();
  }
}
