
import 'package:flutter/foundation.dart';

class TypeRadioProvider with ChangeNotifier {
  int selected;

  changeState(val) {
    selected = val;
    notifyListeners();
  }
}
