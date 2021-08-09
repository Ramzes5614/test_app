import 'package:flutter/cupertino.dart';

enum CheckBoxTypes {
  red,
  green,
  yellow,
}

///The controller class for our widgets
class CheckBoxController extends ChangeNotifier {
  CheckBoxTypes currentSelectedType = CheckBoxTypes.green;
  ///animation speed in ms
  int animationSpeed = 200;

  void setCheckBoxType(CheckBoxTypes type) {
    currentSelectedType = type;
    notifyListeners();
  }

  void setAnimationSpeed(int speed) {
    animationSpeed = speed;
    notifyListeners();
  }
}
