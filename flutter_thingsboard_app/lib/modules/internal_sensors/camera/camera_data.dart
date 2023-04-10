/*
import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:requests/requests.dart';
import 'package:flutter/material.dart';

void sendTelemetry(XFile F, String path) async {
  var file = File(path);
  var fileBytes = file.readAsBytesSync();
  String base64File = base64Encode(fileBytes);
  var accelData = {'file': base64File};
  String URLendpoint = 'http://variot.ece.drexel.edu';
  String APItoken = 'FCrxDyxMljJ6nOUxAD11';
  String URL = URLendpoint + '/api/v1/' + APItoken + '/telemetry';
  try {
    var r = await Requests.post(URL,
        json: accelData,
        verify: false,
        headers: {"Content-Type": "application/json"});
  } catch (e) {
    print("${e}");
  }
}
*/