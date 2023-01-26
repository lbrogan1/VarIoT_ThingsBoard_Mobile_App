import 'package:sensors_plus/sensors_plus.dart';

double x = 0;
double y = 0;
double z = 0;

String getMagData() {
  magnetometerEvents.listen(
    (MagnetometerEvent event) {
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
