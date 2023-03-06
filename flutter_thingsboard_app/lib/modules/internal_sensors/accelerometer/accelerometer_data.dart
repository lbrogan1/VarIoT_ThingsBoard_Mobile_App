import 'package:sensors_plus/sensors_plus.dart';
import 'package:requests/requests.dart';
import 'dart:convert';

double x = 0;
double y = 0;
double z = 0;

String token = "";

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
  sendTelemetry(xS, yS, zS);
  getAccessToken();
  createNewDevice();
  return xS + "," + yS + "," + zS;
}

void sendTelemetry(String xData, String yData, String zData) async {
  var accelData = {'x': xData, 'y': yData, 'z': zData};
  String URLendpoint = 'http://variot.ece.drexel.edu';
  String APItoken = '9gvIUQEXdwl0qrZtqmsJ';
  String URL = URLendpoint + '/api/v1/' + APItoken + '/telemetry';
  var r = await Requests.post(URL,
      json: accelData,
      verify: false,
      headers: {"Content-Type": "application/json"});
  //r.raiseForStatus();
  //dynamic json = r.json;
  //print(json!['id']);
}

void getAccessToken() async {
  String username = 'lwb32@drexel.edu';
  String password = '*********';
  String URLendpoint = 'http://variot.ece.drexel.edu';
  String URL = URLendpoint + '/api/auth/login';
  Map<String, String> headers = {'Content-Type': 'application/json'};
  var r = await Requests.post(
    URL,
    json: <String, String>{'username': username, 'password': password},
    headers: headers,
  );
  final responseJson = json.decode(r.body);
  token = responseJson['token'];
  //print("$token");
}

void createNewDevice() async {
  String URLendpoint = 'http://variot.ece.drexel.edu';
  String URL = URLendpoint + '/api/device?accessToken=' + token;
  Map<String, String> headers = {'Content-Type': 'application/json'};
  var r = await Requests.post(URL,
      json: <String, String>{'name': 'Api Test', 'type': 'Smartphone Sensors'},
      headers: headers);
  if (r.statusCode == 200) {
    print('Device added successfully');
  } else {
    var statusCode = r.statusCode;
    print('Failed to add device - $statusCode');
  }
}
