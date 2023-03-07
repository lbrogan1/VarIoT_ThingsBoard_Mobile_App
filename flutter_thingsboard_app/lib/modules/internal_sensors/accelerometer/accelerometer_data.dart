import 'package:sensors_plus/sensors_plus.dart';
import 'package:requests/requests.dart';
import 'dart:convert';
import 'dart:async';

import 'package:thingsboard_app/widgets/login_vars.dart';

double x = 0;
double y = 0;
double z = 0;

String getAccelData() {
  accelerometerEvents.listen(
    (AccelerometerEvent event) {
      x = event.x;
      y = event.y;
      z = event.z;
    },
  );
  String xS = x.toString();
  String yS = y.toString();
  String zS = z.toString();
  //Decide if we should create device or get info
  longin_vars.getAllDevices();

  //Future<String> APIToken = longin_vars.allDeviceCreate("Accelerometer");
  //sendTelemetry(xS, yS, zS, APIToken);
  return xS + "," + yS + "," + zS;
}

void sendTelemetry(
    String xData, String yData, String zData, Future<String> APIToken) async {
  String _APIToken = await APIToken;
  var accelData = {'x': xData, 'y': yData, 'z': zData};
  String URLendpoint = 'http://variot.ece.drexel.edu';
  String URL = URLendpoint + '/api/v1/' + _APIToken + '/telemetry';
  var r = await Requests.post(URL,
      json: accelData,
      verify: false,
      headers: {"Content-Type": "application/json"});
  //r.raiseForStatus();
  //dynamic json = r.json;
  //print(json!['id']);
}
