import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:thingsboard_app/generated/l10n.dart';
import 'package:thingsboard_app/modules/profile/change_password_page.dart';
import 'package:thingsboard_app/widgets/tb_app_bar.dart';
import 'package:thingsboard_app/core/entity/entities_list.dart';
import 'package:thingsboard_app/modules/internal_sensors/camera/camera_data.dart';
import 'package:thingsboard_app/modules/internal_sensors/camera/camera_list.dart';

import 'package:thingsboard_app/core/context/tb_context.dart';
import 'package:thingsboard_app/core/context/tb_context_widget.dart';
import 'package:thingsboard_app/core/entity/entities_base.dart';
import 'package:thingsboard_app/modules/audit_log/audit_logs_list.dart';
import 'package:thingsboard_app/modules/internal_sensors/internal_sensors_list.dart';
//import 'package:thingsboard_app/modules/internal_sensors/accel_list.dart';
import 'package:thingsboard_app/widgets/tb_app_bar.dart';

import 'package:thingsboard_app/core/context/tb_context.dart';
import 'package:thingsboard_app/core/context/tb_context_widget.dart';
import 'package:thingsboard_app/widgets/tb_progress_indicator.dart';
import 'package:thingsboard_client/thingsboard_client.dart';

class CameraPage extends TbPageWidget {
  final bool searchMode;

  CameraPage(TbContext tbContext, {this.searchMode = false}) : super(tbContext);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends TbPageState<CameraPage> {
  final PageLinkController _pageLinkController = PageLinkController();
  late List<CameraDescription> cameras;
  late CameraController cameraController;

  @override
  void dispose() {
    _pageLinkController.dispose();
    cameraController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    startCamera();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var assetsList = CameraList(tbContext, _pageLinkController,
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
    if (cameraController.value.isInitialized) {
      return Scaffold(
        appBar: appBar,
        body: Stack(
          children: [
            CameraPreview(cameraController),
            GestureDetector(
              onTap: () {
                setState(() {
                  startCamera();
                });
              },
              child:
                  button(Icons.flip_camera_ios_outlined, Alignment.bottomLeft),
            ),
            GestureDetector(
              onTap: () {
                cameraController.takePicture().then((XFile? file) {
                  if (mounted) {
                    if (file != null) {
                      print("Picture saved to ${file.path}");
                      sendTelemetry(file);
                      print("Telemetry sent ${file}");
                    }
                  }
                });
              },
              child: button(Icons.camera_alt_outlined, Alignment.bottomCenter),
            ),
            Align(
              alignment: AlignmentDirectional.topCenter,
              child: Text(
                "",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget button(IconData icon, Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.only(
          left: 20,
          bottom: 20,
        ),
        height: 50,
        width: 50,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(2, 2),
              blurRadius: 10,
            ),
          ],
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }

  void startCamera() async {
    cameras = await availableCameras();

    cameraController = CameraController(
      cameras[0],
      ResolutionPreset.high,
      enableAudio: false,
    );

    await cameraController.initialize().then((value) {
      setState(() {}); //To refresh widget
    }).catchError((e) {
      print(e);
    });
    return;
  }
}
