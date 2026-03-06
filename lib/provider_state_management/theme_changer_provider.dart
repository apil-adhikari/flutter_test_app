import 'package:flutter/material.dart';

class ThemeChangerProvider extends ChangeNotifier {
  bool _isSystemTheme = true;
  bool get systemTheme => _isSystemTheme;

  // Initially set the theme to the system mode:
  ThemeMode _currentTheme = ThemeMode.system;
  ThemeMode get currentTheme => _currentTheme;

  void setTheme(ThemeMode themeMode) {
    _currentTheme = themeMode;
    _isSystemTheme = themeMode == ThemeMode.system;
    notifyListeners();
  }

  void useSystemTheme() => setTheme(ThemeMode.system);
  void useLightTheme() => setTheme(ThemeMode.light);
  void useDarkTheme() => setTheme(ThemeMode.dark);

  // // Toggling the system theme:
  // void useSystemTheme(bool useSystemTheme) {
  //   _currentTheme = useSystemTheme ? ThemeMode.system : ThemeMode.light;
  //   _isSystemTheme = useSystemTheme;
  //   notifyListeners();
  // }

  // // Function to toggle theme:
  // void toggleTheme(ThemeMode themeMode) {
  //   // this function can accept either dart or light mode
  //   _currentTheme = themeMode;
  //   notifyListeners();
  // }

  // Toggle between the light and dark theme:
  void toggleLightDark(ThemeMode mode) {
    _isSystemTheme = false;
    _currentTheme = _currentTheme == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    notifyListeners();
  }
}
