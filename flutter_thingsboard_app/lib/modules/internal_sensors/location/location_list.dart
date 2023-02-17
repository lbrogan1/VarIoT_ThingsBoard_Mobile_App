import 'package:thingsboard_app/core/context/tb_context.dart';
import 'package:thingsboard_app/core/entity/entities_base.dart';
import 'package:thingsboard_app/core/entity/entities_list.dart';
import 'package:thingsboard_app/modules/internal_sensors/location/location_base.dart';
import 'package:thingsboard_client/thingsboard_client.dart';

class LocationList extends BaseEntitiesWidget<AssetInfo, PageLink>
    with LocationBase, EntitiesListStateBase {
  LocationList(
      TbContext tbContext, PageKeyController<PageLink> pageKeyController,
      {searchMode = false})
      : super(tbContext, pageKeyController, searchMode: searchMode);
}
