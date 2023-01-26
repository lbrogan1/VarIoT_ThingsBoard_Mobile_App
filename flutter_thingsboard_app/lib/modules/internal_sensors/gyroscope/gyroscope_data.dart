import 'package:sensors_plus/sensors_plus.dart';

double x = 0;
double y = 0;
double z = 0;

String getGyroData() {
  gyroscopeEvents.listen(
    (GyroscopeEvent event) {
      x = event.x;
      y = event.y;
      z = event.z;
    },
  );
  String xS = x.toString();
  String yS = y.toString();
  String zS = z.toString();
  return xS + "," + yS + "," + zS;
}
