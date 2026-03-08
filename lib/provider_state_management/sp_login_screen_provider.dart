import 'package:flutter/material.dart';

class SpLoginScreenProvider extends ChangeNotifier {
  bool _showPassword = false;
  bool get showPassword => _showPassword;

  // Global state for knowing if the user is loggein or not
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  // Function to change the logged in state
  // void setLoggedIn() {

  // }

  // Function to toggle the password
  void toggleShowPassword() {
    _showPassword = !showPassword;
    notifyListeners();
  }
}
