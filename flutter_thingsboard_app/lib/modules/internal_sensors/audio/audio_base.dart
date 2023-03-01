import 'package:flutter/material.dart';
import 'package:thingsboard_app/core/entity/entities_base.dart';
import 'package:thingsboard_client/thingsboard_client.dart';

mixin AudioBase on EntitiesBase<AssetInfo, PageLink> {
  @override
  String get title => 'Audio Data';

  @override
  String get noItemsFoundText => 'No data found';

  @override
  Future<PageData<AssetInfo>> fetchEntities(PageLink pageLink) {
    if (tbClient.isTenantAdmin()) {
      return tbClient.getAssetService().getTenantAssetInfos(pageLink);
    } else {
      return tbClient
          .getAssetService()
          .getCustomerAssetInfos(tbClient.getAuthUser()!.customerId!, pageLink);
    }
  }

  @override
  void onEntityTap(AssetInfo asset) {
    navigateTo('/asset/${asset.id!.id}');
  }
}
