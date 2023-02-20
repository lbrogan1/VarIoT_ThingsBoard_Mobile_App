import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';
import 'package:thingsboard_app/config/routes/router.dart';
import 'package:thingsboard_app/core/context/tb_context.dart';
import 'package:thingsboard_app/modules/audit_log/audit_logs_page.dart';
import 'package:thingsboard_app/modules/internal_sensors/internal_sensors_page.dart';
import 'package:thingsboard_app/modules/internal_sensors/biometrics/biometrics_page.dart';
import 'package:universal_html/html.dart';

class BioRoutes extends TbRoutes {
  late var bioRoutesHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    var searchMode = params['search']?.first == 'true';
    return BioPage(tbContext, searchMode: searchMode);
  });

  BioRoutes(TbContext tbContext) : super(tbContext);

  @override
  void doRegisterRoutes(router) {
    router.define("/internalSensors/biometrics", handler: bioRoutesHandler);
  }
}
