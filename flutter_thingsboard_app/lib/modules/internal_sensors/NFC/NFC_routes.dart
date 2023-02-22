import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';
import 'package:thingsboard_app/config/routes/router.dart';
import 'package:thingsboard_app/core/context/tb_context.dart';
import 'package:thingsboard_app/modules/audit_log/audit_logs_page.dart';
import 'package:thingsboard_app/modules/internal_sensors/internal_sensors_page.dart';
import 'package:thingsboard_app/modules/internal_sensors/NFC/NFC_page.dart';
import 'package:universal_html/html.dart';

class NFCRoutes extends TbRoutes {
  late var NFCRoutesHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    var searchMode = params['search']?.first == 'true';
    return NFCPage(tbContext, searchMode: searchMode);
  });

  NFCRoutes(TbContext tbContext) : super(tbContext);

  @override
  void doRegisterRoutes(router) {
    router.define("/internalSensors/NFC", handler: NFCRoutesHandler);
  }
}
