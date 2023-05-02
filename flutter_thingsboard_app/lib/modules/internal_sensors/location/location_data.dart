import 'package:geolocator/geolocator.dart';
import 'package:requests/requests.dart';
import 'dart:convert';
import 'dart:async';

import 'package:thingsboard_app/widgets/login_vars.dart';

String lat = "";
String long = "";
String alt = "";
String floor = "";

String latDisplay = "";
String longDisplay = "";

Future<Position> getLocation() async {
  return await Geolocator.getCurrentPosition();
}

Future<String> setLocationData() async {
  LocationPermission permission;
  permission = await Geolocator.requestPermission();

  Position pos = await getLocation();

  lat = pos.latitude.toString();
  long = pos.longitude.toString();
  alt = pos.altitude.toString();
  floor = pos.floor.toString();

  latDisplay = pos.latitude.toStringAsFixed(4);
  longDisplay = pos.longitude.toStringAsFixed(4);

  return lat + "," + long + "," + alt + "," + floor;
}

String getLocationData() {
  Future<bool> isAdded = longin_vars.getAllDevices("GPS");
  decideTelemtery(lat, long, alt, floor, isAdded);
  return latDisplay + "," + longDisplay + "," + alt + "," + floor;
}

void decideTelemtery(String lat1, String long1, String alt1, String floor1,
    Future<bool> isAdded) async {
  bool _isAdded = await isAdded;
  Future<String> APIToken;
  if (_isAdded) {
    APIToken = longin_vars.getDeviceAPIToken("GPS");
    sendTelemetry(lat1, long1, alt1, floor1, APIToken);
  } else {
    APIToken = longin_vars.allDeviceCreate("GPS");
    sendTelemetry(lat1, long1, alt1, floor1, APIToken);
  }
}

void sendTelemetry(String lat, String long, String alt, String floor,
    Future<String> APIToken) async {
  String _APIToken = await APIToken;
  var accelData = {'lat': lat, 'long': long, 'altitude': alt, 'floor': floor};
  String URLendpoint = 'http://variot.ece.drexel.edu';
  String URL = URLendpoint + '/api/v1/' + _APIToken + '/telemetry';
  var r = await Requests.post(URL,
      json: accelData,
      verify: false,
      headers: {"Content-Type": "application/json"});
}
