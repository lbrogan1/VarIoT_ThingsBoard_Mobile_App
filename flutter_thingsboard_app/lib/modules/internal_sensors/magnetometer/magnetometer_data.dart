import 'package:sensors_plus/sensors_plus.dart';
import 'package:requests/requests.dart';

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
  sendTelemetry(xS, yS, zS);
  return xS + "," + yS + "," + zS;
}

void sendTelemetry(String xData, String yData, String zData) async {
  var accelData = {'x': xData, 'y': yData, 'z': zData};
  String URLendpoint = 'http://variot.ece.drexel.edu';
  String APItoken = '3wE3kqFHGlQZ3kzDRYOu';
  String URL = URLendpoint + '/api/v1/' + APItoken + '/telemetry';
  var r = await Requests.post(URL,
      json: accelData,
      verify: false,
      headers: {"Content-Type": "application/json"});
  //r.raiseForStatus();
  //dynamic json = r.json;
  //print(json!['id']);
}
