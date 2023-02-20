import 'package:geolocator/geolocator.dart';
import 'package:requests/requests.dart';

String lat = "";
String long = "";
String alt = "";
String floor = "";

Future<Position> getLocation() async {
  return await Geolocator.getCurrentPosition();
}

Future<String> setLocationData() async {
  Position pos = await getLocation();

  lat = pos.latitude.toString();
  long = pos.longitude.toString();
  alt = pos.altitude.toString();
  floor = pos.floor.toString();

  return lat + "," + long + "," + alt + "," + floor;
}

String getLocationData() {
  sendTelemetry(lat, long, alt, floor);
  return lat + "," + long + "," + alt + "," + floor;
}

void sendTelemetry(String lat, String long, String alt, String floor) async {
  var accelData = {'lat': lat, 'long': long, 'altitude': alt, 'floor': floor};
  String URLendpoint = 'http://variot.ece.drexel.edu';
  String APItoken = 'PCWddA3Xn1eW24Sqlw38';
  String URL = URLendpoint + '/api/v1/' + APItoken + '/telemetry';
  var r = await Requests.post(URL,
      json: accelData,
      verify: false,
      headers: {"Content-Type": "application/json"});
}
