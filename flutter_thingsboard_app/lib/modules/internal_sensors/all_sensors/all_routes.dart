import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';
import 'package:thingsboard_app/config/routes/router.dart';
import 'package:thingsboard_app/core/context/tb_context.dart';
import 'package:thingsboard_app/modules/audit_log/audit_logs_page.dart';
import 'package:thingsboard_app/modules/internal_sensors/internal_sensors_page.dart';
import 'package:thingsboard_app/modules/internal_sensors/all_sensors/all_page.dart';
import 'package:universal_html/html.dart';

class AllRoutes extends TbRoutes {
  late var allRoutesHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    var searchMode = params['search']?.first == 'true';
    return AllPage(tbContext, searchMode: searchMode);
  });

  AllRoutes(TbContext tbContext) : super(tbContext);

  @override
  void doRegisterRoutes(router) {
    router.define("/internalSensors/all_sensors", handler: allRoutesHandler);
  }
}
