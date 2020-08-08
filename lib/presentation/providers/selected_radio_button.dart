import 'package:flutter/material.dart';

class RadioProvider with ChangeNotifier {
  int selected;

  changeState(val) {
    selected = val;
    notifyListeners();
  }
}
