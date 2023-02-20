import 'package:camera/camera.dart';
import 'package:requests/requests.dart';
import 'package:flutter/material.dart';

void sendTelemetry(XFile F) async {
  var accelData = {'file': F};
  String URLendpoint = 'http://variot.ece.drexel.edu';
  String APItoken = 'FCrxDyxMljJ6nOUxAD11';
  String URL = URLendpoint + '/api/v1/' + APItoken + '/telemetry';
  var r = await Requests.post(URL,
      json: accelData, verify: false, headers: {"Content-Type": "image/jpeg"});
}
