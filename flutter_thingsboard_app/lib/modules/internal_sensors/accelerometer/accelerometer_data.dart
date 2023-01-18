import 'dart:_foreign_helper';
import 'dart:html';

import 'package:sensors_plus/sensors_plus.dart';

AccelerometerEvent getAccelData() {
  accelerometerEvents.listen(AccelerometerEvent event);
  return event;
}

void initState() {
  accelerometerEvents.listen(
    (AccelerometerEvent event) {
      var x = event.x;
      var y = event.y;
      var z = event.z;
    },
  ),
};