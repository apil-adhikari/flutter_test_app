import 'package:flutter/material.dart';

class ExampleTwoProvider extends ChangeNotifier {
  double _currentValue = 255;
  double get currentValue => _currentValue;

  void setAlpha(double val) {
    _currentValue = val;
    notifyListeners();
  }
}
