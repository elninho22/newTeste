
import 'package:applocation/core/network/check_connecting_network.dart';
import 'package:applocation/core/services/location_app_service.dart';
import 'package:applocation/core/services/location_service.dart';
import 'package:applocation/modules/debug_view/controllers/debug_view_controller.dart';

import '/core/network/network.dart';
import '../external/datasource/appview_datasource_impl.dart';
import '../presenter/controller/appview_controller.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class AppViewBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(Dio());
    Get.put(CheckConnectingNetwork());
    Get.put(Network(Get.find<Dio>()));
    Get.put(AppViewDatasourceImpl(Get.find<Network>()));
    Get.put(LocationAppService());
    Get.put(DebugViewController());
    Get.put(LocationService());
    Get.put(AppViewController(
      request: Get.find<AppViewDatasourceImpl>(),
      locationApp: Get.find<LocationAppService>(),
      connectivityStore: Get.find<CheckConnectingNetwork>(),
      debugViewController: Get.find<DebugViewController>(),
      serviceLocation: Get.find<LocationService>(),
    ));
  }
}
