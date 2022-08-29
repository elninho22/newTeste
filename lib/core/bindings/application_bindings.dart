import 'package:applocation/modules/debug_view/controllers/debug_view_controller.dart';
import 'package:get/get.dart';

class ApplicationBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(DebugViewController());
  }
}
