import 'package:flutter/material.dart';

class FavouriteProvider extends ChangeNotifier {
  final List<int> _favouriteItems = [];
  List<int> get favouriteItems => _favouriteItems;

  void addToFavourite(int value) {
    _favouriteItems.add(value);
    notifyListeners();
  }

  void removeFromFavourite(int value) {
    _favouriteItems.remove(value);
    notifyListeners();
  }

  bool checkIsFavourite(int value) {
    final isFav = _favouriteItems.contains(value);

    return isFav;
  }
}
