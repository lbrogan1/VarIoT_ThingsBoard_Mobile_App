import 'package:geolocator/geolocator.dart';
import 'package:requests/requests.dart';

String lat = "";
String long = "";

Future<Position> getLocation() async {
  return await Geolocator.getCurrentPosition();
}

Future<String> setLocationData() async {
  Position pos = await getLocation();

  lat = pos.latitude.toString();
  long = pos.longitude.toString();

  return lat + "," + long;
}

String getLocationData() {
  sendTelemetry(lat, long);
  return lat + "," + long;
}

void sendTelemetry(String lat, String long) async {
  var accelData = {'lat': lat, 'long': long};
  String URLendpoint = 'http://variot.ece.drexel.edu';
  String APItoken = 'PCWddA3Xn1eW24Sqlw38';
  String URL = URLendpoint + '/api/v1/' + APItoken + '/telemetry';
  var r = await Requests.post(URL,
      json: accelData,
      verify: false,
      headers: {"Content-Type": "application/json"});
}
