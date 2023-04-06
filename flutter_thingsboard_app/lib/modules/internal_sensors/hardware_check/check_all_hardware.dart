import 'package:sensors_plus/sensors_plus.dart';
import 'package:geolocator/geolocator.dart';

import 'package:thingsboard_app/modules/internal_sensors/hardware_check/hardware_check_values.dart';

//This needs to be completed when app intiiatly opens
//List that is returned needs to be passed to the hardware page so the
//selection can be greyed out

void checkHardwareForSensors() {
  checkForAccel();
  checkForGyro();
  checkForMag();
}

void checkForAccel() async {
  var check = 1;

  try {
    final accelData = await accelerometerEvents.first;
  } catch (exception) {
    check = 0;
  }

  hardware_check_values.hasAccel = check;
}

void checkForGyro() async {
  var check = 1;

  try {
    final gyroData = await gyroscopeEvents.first;
  } catch (exception) {
    check = 0;
  }

  hardware_check_values.hasGyro = check;
}

void checkForMag() async {
  var check = 1;

  try {
    final magData = await magnetometerEvents.first;
  } catch (exception) {
    check = 0;
  }

  hardware_check_values.hasMag = check;
}

void checkForLocation() async {
  var check = 1;

  bool hasGpsSensor = await Geolocator.isLocationServiceEnabled();

  if (hasGpsSensor == false) {
    check = 0;
  }

  hardware_check_values.hasLocation = check;
}
