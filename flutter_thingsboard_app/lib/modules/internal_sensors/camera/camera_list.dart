import 'package:thingsboard_app/core/context/tb_context.dart';
import 'package:thingsboard_app/core/entity/entities_base.dart';
import 'package:thingsboard_app/core/entity/entities_list.dart';
import 'package:thingsboard_app/modules/internal_sensors/camera/camera_base.dart';
import 'package:thingsboard_client/thingsboard_client.dart';

class CameraList extends BaseEntitiesWidget<AssetInfo, PageLink>
    with CameraBase, EntitiesListStateBase {
  CameraList(TbContext tbContext, PageKeyController<PageLink> pageKeyController,
      {searchMode = false})
      : super(tbContext, pageKeyController, searchMode: searchMode);
}
