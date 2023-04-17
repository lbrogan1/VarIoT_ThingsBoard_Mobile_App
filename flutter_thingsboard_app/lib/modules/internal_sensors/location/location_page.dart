import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:thingsboard_app/generated/l10n.dart';
import 'package:thingsboard_app/modules/profile/change_password_page.dart';
import 'package:thingsboard_app/widgets/tb_app_bar.dart';
import 'package:thingsboard_app/core/entity/entities_list.dart';
import 'package:thingsboard_app/modules/internal_sensors/location/location_data.dart';
import 'package:thingsboard_app/modules/internal_sensors/accelerometer/accelerometer_data.dart';

import 'package:thingsboard_app/core/context/tb_context.dart';
import 'package:thingsboard_app/core/context/tb_context_widget.dart';
import 'package:thingsboard_app/core/entity/entities_base.dart';
import 'package:thingsboard_app/modules/audit_log/audit_logs_list.dart';
import 'package:thingsboard_app/modules/internal_sensors/internal_sensors_list.dart';
import 'package:thingsboard_app/modules/internal_sensors/location/location_list.dart';
import 'package:thingsboard_app/widgets/tb_app_bar.dart';

import 'package:thingsboard_app/core/context/tb_context.dart';
import 'package:thingsboard_app/core/context/tb_context_widget.dart';
import 'package:thingsboard_app/widgets/tb_progress_indicator.dart';
import 'package:thingsboard_client/thingsboard_client.dart';

class LocationPage extends TbPageWidget {
  final bool searchMode;

  LocationPage(TbContext tbContext, {this.searchMode = false})
      : super(tbContext);

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends TbPageState<LocationPage> {
  final PageLinkController _pageLinkController = PageLinkController();

  @override
  void dispose() {
    _pageLinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var assetsList = LocationList(tbContext, _pageLinkController,
        searchMode: widget.searchMode);
    PreferredSizeWidget appBar;
    appBar = TbAppBar(tbContext, title: Text(assetsList.title), actions: [
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          navigateTo('/assets?search=true');
        },
      )
    ]);
    List<String> locationDataList = getLocationText();
    return Scaffold(
        appBar: appBar,
        body: Row(mainAxisSize: MainAxisSize.max, children: [
          Flexible(
              fit: FlexFit.tight,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(width: 16),
                    Flexible(
                        fit: FlexFit.tight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  FittedBox(
                                      fit: BoxFit.fitWidth,
                                      alignment: Alignment.centerLeft,
                                      child: Text(locationDataList[0],
                                          style: TextStyle(
                                              color: Color(0xFF282828),
                                              fontSize: 22,
                                              fontWeight: FontWeight.w500,
                                              height: 20 / 14))),
                                ]),
                            SizedBox(height: 4),
                            Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  FittedBox(
                                      fit: BoxFit.fitWidth,
                                      alignment: Alignment.centerLeft,
                                      child: Text(locationDataList[1],
                                          style: TextStyle(
                                              color: Color(0xFF282828),
                                              fontSize: 22,
                                              fontWeight: FontWeight.w500,
                                              height: 20 / 14))),
                                ]),
                            /*
                            Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  FittedBox(
                                      fit: BoxFit.fitWidth,
                                      alignment: Alignment.centerLeft,
                                      child: Text(locationDataList[2],
                                          style: TextStyle(
                                              color: Color(0xFF282828),
                                              fontSize: 22,
                                              fontWeight: FontWeight.w500,
                                              height: 20 / 14))),
                                ]),
                            Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  FittedBox(
                                      fit: BoxFit.fitWidth,
                                      alignment: Alignment.centerLeft,
                                      child: Text(locationDataList[3],
                                          style: TextStyle(
                                              color: Color(0xFF282828),
                                              fontSize: 22,
                                              fontWeight: FontWeight.w500,
                                              height: 20 / 14))),
                                ]),
                                */
                            SizedBox(height: 4),
                          ],
                        )),
                    SizedBox(width: 16),
                    Icon(Icons.chevron_right, color: Color(0xFFACACAC)),
                    SizedBox(width: 16)
                  ],
                ),
              ))
        ]));
  }

  List<String> getLocationText() {
    setLocationData();
    String data = getLocationData();
    var split = data.split(',');
    List<String> dataText = [
      "Latitude: " + split[0],
      "Longitude: " + split[1],
      "Altitude: " + split[2],
      "Floor: " + split[3],
    ];
    return dataText;
  }
}
