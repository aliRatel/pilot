
import 'package:flutter/foundation.dart';

class GenderRadioProvider with ChangeNotifier {
  int selected;

  changeState(val) {
    selected = val;
    notifyListeners();
  }
}
