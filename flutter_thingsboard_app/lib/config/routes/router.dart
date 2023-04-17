import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:thingsboard_app/core/auth/auth_routes.dart';
import 'package:thingsboard_app/core/context/tb_context.dart';
import 'package:thingsboard_app/core/init/init_routes.dart';
import 'package:thingsboard_app/modules/alarm/alarm_routes.dart';
import 'package:thingsboard_app/modules/asset/asset_routes.dart';
import 'package:thingsboard_app/modules/audit_log/audit_logs_routes.dart';
import 'package:thingsboard_app/modules/internal_sensors/internal_sensors_routes.dart';
import 'package:thingsboard_app/modules/customer/customer_routes.dart';
import 'package:thingsboard_app/modules/dashboard/dashboard_routes.dart';
import 'package:thingsboard_app/modules/device/device_routes.dart';
import 'package:thingsboard_app/modules/home/home_routes.dart';
import 'package:thingsboard_app/modules/profile/profile_routes.dart';
import 'package:thingsboard_app/modules/tenant/tenant_routes.dart';
import 'package:thingsboard_app/utils/ui_utils_routes.dart';
import 'package:thingsboard_app/modules/internal_sensors/accelerometer/accel_routes.dart';
import 'package:thingsboard_app/modules/internal_sensors/gyroscope/gyro_routes.dart';
import 'package:thingsboard_app/modules/internal_sensors/magnetometer/mag_routes.dart';
//import 'package:thingsboard_app/modules/internal_sensors/camera/camera_routes.dart';
import 'package:thingsboard_app/modules/internal_sensors/location/location_routes.dart';
import 'package:thingsboard_app/modules/internal_sensors/biometrics/biometrics_routes.dart';
import 'package:thingsboard_app/modules/internal_sensors/NFC/NFC_routes.dart';
import 'package:thingsboard_app/modules/internal_sensors/all_sensors/all_routes.dart';
import 'package:thingsboard_app/modules/internal_sensors/audio/audio_routes.dart';
import 'package:universal_html/html.dart';

class ThingsboardAppRouter {
  final router = FluroRouter();
  late final _tbContext = TbContext(router);

  ThingsboardAppRouter() {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      var settings = context!.settings;
      return Scaffold(
        appBar: AppBar(title: null), //Text('Not Found')),
        body: Center(
            child: null), //Text('Route not defined: ${settings!.name}')),
      );
    });
    InitRoutes(_tbContext).registerRoutes();
    AuthRoutes(_tbContext).registerRoutes();
    UiUtilsRoutes(_tbContext).registerRoutes();
    HomeRoutes(_tbContext).registerRoutes();
    ProfileRoutes(_tbContext).registerRoutes();
    AssetRoutes(_tbContext).registerRoutes();
    DeviceRoutes(_tbContext).registerRoutes();
    AlarmRoutes(_tbContext).registerRoutes();
    DashboardRoutes(_tbContext).registerRoutes();
    AuditLogsRoutes(_tbContext).registerRoutes();
    InternalSensorsRoutes(_tbContext).registerRoutes();
    AccelerometerRoutes(_tbContext).registerRoutes();
    GyroscopeRoutes(_tbContext).registerRoutes();
    MagnetometerRoutes(_tbContext).registerRoutes();
    //CameraRoutes(_tbContext).registerRoutes();
    LocationRoutes(_tbContext).registerRoutes();
    BioRoutes(_tbContext).registerRoutes();
    NFCRoutes(_tbContext).registerRoutes();
    AllRoutes(_tbContext).registerRoutes();
    AudioRoutes(_tbContext).registerRoutes();
    CustomerRoutes(_tbContext).registerRoutes();
    TenantRoutes(_tbContext).registerRoutes();
  }

  TbContext get tbContext => _tbContext;
}

abstract class TbRoutes {
  final TbContext _tbContext;

  TbRoutes(this._tbContext);

  void registerRoutes() {
    doRegisterRoutes(_tbContext.router);
  }

  void doRegisterRoutes(FluroRouter router);

  TbContext get tbContext => _tbContext;
}
