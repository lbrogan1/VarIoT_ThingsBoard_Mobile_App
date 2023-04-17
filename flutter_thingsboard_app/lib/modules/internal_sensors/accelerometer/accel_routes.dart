import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';
import 'package:thingsboard_app/config/routes/router.dart';
import 'package:thingsboard_app/core/context/tb_context.dart';
import 'package:thingsboard_app/modules/audit_log/audit_logs_page.dart';
import 'package:thingsboard_app/modules/internal_sensors/internal_sensors_page.dart';
import 'package:thingsboard_app/modules/internal_sensors/accelerometer/accel_page.dart';
import 'package:universal_html/html.dart';

class AccelerometerRoutes extends TbRoutes {
  late var accelerometerRoutesHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    var searchMode = params['search']?.first == 'true';
    return AcclPage(tbContext, searchMode: searchMode);
  });

  AccelerometerRoutes(TbContext tbContext) : super(tbContext);

  @override
  void doRegisterRoutes(router) {
    router.define("/internalSensors/accel",
        handler: accelerometerRoutesHandler);
  }
}
