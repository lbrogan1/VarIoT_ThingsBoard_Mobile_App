import 'package:requests/requests.dart';
import 'dart:convert';
import 'dart:async';

class longin_vars {
  static var username = "";
  static var password = "";
  static var accToken = "";
  static String? refrshAccToken = "";
  static var ident = "";

  static var AccelIDNum = "empty";
  static var AccelAccessToken = "empty";

  longin_vars._();

  static void getAllDevices() async {
    var split = longin_vars.username.split('@');
    longin_vars.ident = split[0];
    Future<String> accessT = longin_vars.getAccessToken();
    String _accessT = await accessT;
    String URLendpoint = 'http://variot.ece.drexel.edu';
    String URL = URLendpoint +
        '/api/tenant/devices?pageSize=100&page=0&textSearch=' +
        longin_vars.ident;
    ;
    print('$URL');
    Map<String, String> headers = {
      "Accept": 'application/json',
      "Content-Type": 'application/json',
      "X-Authorization": "Bearer " + _accessT
    };
    var r = await Requests.get(URL, headers: headers);
    var responseBody = r.json();
    print('$responseBody');
  }

  static Future<String> allDeviceCreate(String currSensor) {
    var split = longin_vars.username.split('@');
    longin_vars.ident = split[0];
    Future<String> accessT = longin_vars.getAccessToken();
    String name = longin_vars.ident + " " + currSensor;
    Future<String> deviceID = longin_vars.createNewDevice(accessT, name);
    return getAPIToken(deviceID);
  }

  static Future<String> getAPIToken(Future<String> deviceID) async {
    String _deviceID = await deviceID;
    String URLendpoint = 'http://variot.ece.drexel.edu';
    String URL = URLendpoint + '/api/device/' + _deviceID + '/credentials';
    Map<String, String> headers = {
      "Accept": 'application/json',
      "Content-Type": 'application/json',
      "X-Authorization": "Bearer " + longin_vars.accToken
    };
    var r = await Requests.get(URL, headers: headers);
    var responseBody = r.json();
    longin_vars.AccelAccessToken = responseBody['credentialsId'];
    return Future.value(responseBody['credentialsId']);
  }

  static Future<String> getAccessToken() async {
    String username = longin_vars.username;
    String password = longin_vars.password;
    String URLendpoint = 'http://variot.ece.drexel.edu';
    String URL = URLendpoint + '/api/auth/login';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    var r = await Requests.post(
      URL,
      json: <String, String>{'username': username, 'password': password},
      headers: headers,
    );
    final responseJson = json.decode(r.body);
    Future<String> accessT = Future.value(responseJson['token']);
    return accessT;
  }

  static Future<String> createNewDevice(
      Future<String> accessT, String name) async {
    String URLendpoint = 'http://variot.ece.drexel.edu';
    String _accessT = await accessT;
    String URL = URLendpoint + '/api/device';
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      "X-Authorization": "Bearer " + _accessT
    };
    Map<String, String> body = {'name': name, 'type': 'Smartphone Sensors'};
    var r = await Requests.post(URL, json: body, headers: headers);
    var responseBody = r.json();
    if (r.statusCode == 200) {
      print('Device added successfully');
      longin_vars.AccelIDNum = responseBody['id']['id'];
    }
    return Future.value(responseBody['id']['id']);
  }
}
