import 'package:flutter/material.dart';

class hardware_check_values {
  //value of 0 = not present
  //value of 1 = present
  static var hasAccel = 1;
  static var hasGyro = 1;
  static var hasMag = 1;
  static var hasLocation = 1;

  //Not fully implemented - value will never change
  static var hasCamera = 0;
  static var hasBio = 0;
  static var hasNFC = 0;
  static var hasAudio = 0;

  static Color getAccelColor(BuildContext context) {
    if (hasAccel == 1) {
      return Theme.of(context).colorScheme.primary;
    } else {
      return Colors.grey;
    }
  }

  static Color getGyroColor(BuildContext context) {
    if (hasGyro == 1) {
      return Theme.of(context).colorScheme.primary;
    } else {
      return Colors.grey;
    }
  }

  static Color getMagColor(BuildContext context) {
    if (hasMag == 1) {
      return Theme.of(context).colorScheme.primary;
    } else {
      return Colors.grey;
    }
  }

  static Color getLocationColor(BuildContext context) {
    if (hasLocation == 1) {
      return Theme.of(context).colorScheme.primary;
    } else {
      return Colors.grey;
    }
  }
}
