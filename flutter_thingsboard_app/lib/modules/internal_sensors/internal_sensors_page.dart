import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:thingsboard_app/generated/l10n.dart';
import 'package:thingsboard_app/modules/profile/change_password_page.dart';
import 'package:thingsboard_app/widgets/login_vars.dart';
import 'package:thingsboard_app/widgets/tb_app_bar.dart';
import 'package:thingsboard_app/core/entity/entities_list.dart';

import 'package:thingsboard_app/core/context/tb_context.dart';
import 'package:thingsboard_app/core/context/tb_context_widget.dart';
import 'package:thingsboard_app/core/entity/entities_base.dart';
import 'package:thingsboard_app/modules/audit_log/audit_logs_list.dart';
import 'package:thingsboard_app/modules/internal_sensors/internal_sensors_list.dart';
import 'package:thingsboard_app/widgets/tb_app_bar.dart';

import 'package:thingsboard_app/core/context/tb_context.dart';
import 'package:thingsboard_app/core/context/tb_context_widget.dart';
import 'package:thingsboard_app/widgets/tb_progress_indicator.dart';
import 'package:thingsboard_client/thingsboard_client.dart';

import 'package:thingsboard_app/modules/internal_sensors/hardware_check/hardware_check_values.dart';
import 'package:thingsboard_app/modules/internal_sensors/hardware_check/check_all_hardware.dart';

class InternalSensorsPage extends TbPageWidget {
  final bool searchMode;

  InternalSensorsPage(TbContext tbContext, {this.searchMode = false})
      : super(tbContext);

  @override
  _InternalSensorsPageState createState() => _InternalSensorsPageState();
}

class _InternalSensorsPageState extends TbPageState<InternalSensorsPage> {
  final PageLinkController _pageLinkController = PageLinkController();
  final _isLoadingNotifier = ValueNotifier<bool>(true);

  User? _currentUser;

  @override
  void initState() {
    super.initState();
    //_loadUser();
  }

  @override
  void dispose() {
    _pageLinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var assetsList = InternalSensorsList(tbContext, _pageLinkController,
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
    var accelColor = hardware_check_values.getAccelColor(context);
    var gyroColor = hardware_check_values.getGyroColor(context);
    var magColor = hardware_check_values.getMagColor(context);
    var locationColor = hardware_check_values.getLocationColor(context);
    var cameraColor = Colors.grey;
    var bioColor = Colors.grey;
    var NFCColor = Colors.grey;
    var audioColor = Colors.grey;
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    if (hardware_check_values.hasAccel == 1) {
                                      _accelPage();
                                    } else {
                                      null;
                                    }
                                  },
                                  child: Text(
                                    'Accelerometer',
                                    style: TextStyle(
                                        color:
                                            accelColor, //Theme.of(context).colorScheme.primary,
                                        letterSpacing: 1,
                                        fontSize: 35,
                                        height: 16 / 12),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    if (hardware_check_values.hasGyro == 1) {
                                      _gyroPage();
                                    } else {
                                      null;
                                    }
                                  },
                                  child: Text(
                                    'Gyroscope',
                                    style: TextStyle(
                                        color: gyroColor,
                                        letterSpacing: 1,
                                        fontSize: 35,
                                        height: 16 / 12),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    if (hardware_check_values.hasMag == 1) {
                                      _magPage();
                                    } else {
                                      null;
                                    }
                                  },
                                  child: Text(
                                    'Magnetometer',
                                    style: TextStyle(
                                        color: magColor,
                                        letterSpacing: 1,
                                        fontSize: 35,
                                        height: 16 / 12),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    if (hardware_check_values.hasCamera == 1) {
                                      _cameraPage();
                                    } else {
                                      null;
                                    }
                                  },
                                  child: Text(
                                    'Camera',
                                    style: TextStyle(
                                        color: cameraColor,
                                        letterSpacing: 1,
                                        fontSize: 35,
                                        height: 16 / 12),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    if (hardware_check_values.hasLocation ==
                                        1) {
                                      _locationPage();
                                    } else {
                                      null;
                                    }
                                  },
                                  child: Text(
                                    'Location',
                                    style: TextStyle(
                                        color: locationColor,
                                        letterSpacing: 1,
                                        fontSize: 35,
                                        height: 16 / 12),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    if (hardware_check_values.hasBio == 1) {
                                      _biometricPage();
                                    } else {
                                      null;
                                    }
                                  },
                                  child: Text(
                                    'Biometric',
                                    style: TextStyle(
                                        color: bioColor,
                                        letterSpacing: 1,
                                        fontSize: 35,
                                        height: 16 / 12),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    if (hardware_check_values.hasNFC == 1) {
                                      _NFCPage();
                                    } else {
                                      null;
                                    }
                                  },
                                  child: Text(
                                    'NFC',
                                    style: TextStyle(
                                        color: NFCColor,
                                        letterSpacing: 1,
                                        fontSize: 35,
                                        height: 16 / 12),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    if (hardware_check_values.hasAudio == 1) {
                                      _audioPage();
                                    } else {
                                      null;
                                    }
                                  },
                                  child: Text(
                                    'Audio',
                                    style: TextStyle(
                                        color: audioColor,
                                        letterSpacing: 1,
                                        fontSize: 35,
                                        height: 16 / 12),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    _allPage();
                                  },
                                  child: Text(
                                    'All Sensors',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        letterSpacing: 1,
                                        fontSize: 35,
                                        height: 16 / 12),
                                  ),
                                )
                              ],
                            ),
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

  Future<void> _loadUser() async {
    _isLoadingNotifier.value = true;
    _currentUser = await tbClient.getUserService().getUser();
    setUserValues();
    _isLoadingNotifier.value = false;
  }

  void setUserValues() {
    longin_vars.username = _currentUser!.email;
  }

  void _accelPage() async {
    navigateTo('/internalSensors/accel');
  }

  void _gyroPage() async {
    navigateTo('/internalSensors/gyro');
  }

  void _magPage() async {
    navigateTo('/internalSensors/mag');
  }

  void _cameraPage() async {
    navigateTo('/internalSensors/camera');
  }

  void _locationPage() async {
    navigateTo('/internalSensors/location');
  }

  void _biometricPage() async {
    navigateTo('/internalSensors/biometrics');
  }

  void _NFCPage() async {
    navigateTo('/internalSensors/NFC');
  }

  void _allPage() async {
    navigateTo('/internalSensors/all_sensors');
  }

  void _audioPage() async {
    navigateTo('/internalSensors/audio');
  }
}
