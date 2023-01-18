import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';
import 'package:thingsboard_app/config/routes/router.dart';
import 'package:thingsboard_app/core/context/tb_context.dart';
import 'package:thingsboard_app/modules/alarm/alarms_page.dart'; //This needs to change to widgets page
import 'package:thingsboard_app/modules/main/main_page.dart';

class WidgetRoutes extends TbRoutes {
  late var widgetsHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    var searchMode = params['search']?.first == 'true';
    if (searchMode) {
      return WidgetsPage(tbContext, searchMode: true);
    } else {
      return MainPage(tbContext,
          path: '/widgets'); //need to creat this HTML file
    }
  });

  WidgetRoutes(TbContext tbContext) : super(tbContext);

  @override
  void doRegisterRoutes(router) {
    router.define("/widgets", handler: widgetsHandler);
  }
}
