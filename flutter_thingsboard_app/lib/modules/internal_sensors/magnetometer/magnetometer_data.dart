import 'package:sensors_plus/sensors_plus.dart';
import 'package:requests/requests.dart';
import 'dart:convert';
import 'dart:async';

import 'package:thingsboard_app/widgets/login_vars.dart';

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
  String xS = x.toStringAsFixed(2);
  String yS = y.toStringAsFixed(2);
  String zS = z.toStringAsFixed(2);
  Future<bool> isAdded = longin_vars.getAllDevices("Magnetometer");
  decideTelemtery(xS, yS, zS, isAdded);
  return xS + "," + yS + "," + zS;
}

void decideTelemtery(
    String xS, String yS, String zS, Future<bool> isAdded) async {
  bool _isAdded = await isAdded;
  Future<String> APIToken;
  if (_isAdded) {
    APIToken = longin_vars.getDeviceAPIToken("Magnetometer");
    sendTelemetry(xS, yS, zS, APIToken);
  } else {
    APIToken = longin_vars.allDeviceCreate("Magnetometer");
    sendTelemetry(xS, yS, zS, APIToken);
  }
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
