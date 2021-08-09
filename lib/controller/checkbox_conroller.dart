import 'package:flutter/cupertino.dart';

enum CheckBoxTypes {
  red,
  green,
  yellow,
}

///The controller class for our widgets
class CheckBoxController {
  ValueNotifier<CheckBoxTypes> currentSelectedType =
      ValueNotifier<CheckBoxTypes>(CheckBoxTypes.green);

  ///animation speed in ms
  ValueNotifier<int> animationSpeed = ValueNotifier<int>(200);

  void setCheckBoxType(CheckBoxTypes type) {
    currentSelectedType.value = type;
    currentSelectedType.notifyListeners();
  }

  void setAnimationSpeed(int speed) {
    animationSpeed.value = speed;
    animationSpeed.notifyListeners();
  }
}
