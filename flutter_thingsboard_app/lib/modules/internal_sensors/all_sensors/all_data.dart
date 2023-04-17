// Needs to constantly send data for the accelerometer, gyroscope, magnetometer,
// gps, and audio

//good luck

import 'package:sensors_plus/sensors_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:requests/requests.dart';

double xAccel = 0;
double yAccel = 0;
double zAccel = 0;

double xMag = 0;
double yMag = 0;
double zMag = 0;

double xGyro = 0;
double yGyro = 0;
double zGyro = 0;

String lat = "";
String long = "";
String alt = "";
String floor = "";

void runAllSensors() {
  getAccelData();
  getMagData();
  getGyroData();
  setLocationData();
}

void getAccelData() {
  accelerometerEvents.listen(
    (AccelerometerEvent event) {
      xAccel = event.x;
      yAccel = event.y;
      zAccel = event.z;
    },
  );
  String xSAccel = xAccel.toString();
  String ySAccel = yAccel.toString();
  String zSAccel = zAccel.toString();
  sendTelemetryAccel(xSAccel, ySAccel, zSAccel);
}

void getMagData() {
  magnetometerEvents.listen(
    (MagnetometerEvent event) {
      xMag = event.x;
      yMag = event.y;
      zMag = event.z;
    },
  );
  String xSMag = xMag.toString();
  String ySMag = yMag.toString();
  String zSMag = zMag.toString();
  sendTelemetryMag(xSMag, ySMag, zSMag);
}

void getGyroData() {
  gyroscopeEvents.listen(
    (GyroscopeEvent event) {
      xGyro = event.x;
      yGyro = event.y;
      zGyro = event.z;
    },
  );
  String xSGyro = xGyro.toString();
  String ySGyro = yGyro.toString();
  String zSGyro = zGyro.toString();
  sendTelemetryGyro(xSGyro, ySGyro, zSGyro);
}

Future<Position> getLocation() async {
  return await Geolocator.getCurrentPosition();
}

void setLocationData() async {
  Position pos = await getLocation();

  lat = pos.latitude.toString();
  long = pos.longitude.toString();
  alt = pos.altitude.toString();
  floor = pos.floor.toString();

  sendTelemetryLocation(lat, long, alt, floor);
}

void sendTelemetryAccel(String xData, String yData, String zData) async {
  var accelData = {'x': xData, 'y': yData, 'z': zData};
  String URLendpoint = 'http://variot.ece.drexel.edu';
  String APItoken = '9gvIUQEXdwl0qrZtqmsJ';
  String URL = URLendpoint + '/api/v1/' + APItoken + '/telemetry';
  var r = await Requests.post(URL,
      json: accelData,
      verify: false,
      headers: {"Content-Type": "application/json"});
}

void sendTelemetryMag(String xData, String yData, String zData) async {
  var accelData = {'x': xData, 'y': yData, 'z': zData};
  String URLendpoint = 'http://variot.ece.drexel.edu';
  String APItoken = '3wE3kqFHGlQZ3kzDRYOu';
  String URL = URLendpoint + '/api/v1/' + APItoken + '/telemetry';
  var r = await Requests.post(URL,
      json: accelData,
      verify: false,
      headers: {"Content-Type": "application/json"});
}

void sendTelemetryGyro(String xData, String yData, String zData) async {
  var accelData = {'x': xData, 'y': yData, 'z': zData};
  String URLendpoint = 'http://variot.ece.drexel.edu';
  String APItoken = 'gakltwbaTSa0698wrdKb';
  String URL = URLendpoint + '/api/v1/' + APItoken + '/telemetry';
  var r = await Requests.post(URL,
      json: accelData,
      verify: false,
      headers: {"Content-Type": "application/json"});
}

void sendTelemetryLocation(
    String lat, String long, String alt, String floor) async {
  var accelData = {'lat': lat, 'long': long, 'altitude': alt, 'floor': floor};
  String URLendpoint = 'http://variot.ece.drexel.edu';
  String APItoken = 'PCWddA3Xn1eW24Sqlw38';
  String URL = URLendpoint + '/api/v1/' + APItoken + '/telemetry';
  var r = await Requests.post(URL,
      json: accelData,
      verify: false,
      headers: {"Content-Type": "application/json"});
}
