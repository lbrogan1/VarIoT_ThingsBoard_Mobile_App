import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';
import 'package:thingsboard_app/config/routes/router.dart';
import 'package:thingsboard_app/core/context/tb_context.dart';
import 'package:thingsboard_app/modules/audit_log/audit_logs_page.dart';
import 'package:thingsboard_app/modules/internal_sensors/internal_sensors_page.dart';
import 'package:thingsboard_app/modules/internal_sensors/location/location_page.dart';
import 'package:universal_html/html.dart';

class LocationRoutes extends TbRoutes {
  late var locationRoutesHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    var searchMode = params['search']?.first == 'true';
    return LocationPage(tbContext, searchMode: searchMode);
  });

  LocationRoutes(TbContext tbContext) : super(tbContext);

  @override
  void doRegisterRoutes(router) {
    router.define("/internalSensors/location", handler: locationRoutesHandler);
  }
}
