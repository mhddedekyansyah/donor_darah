import 'package:get/get.dart';

import '../controllers/main_home_admin_controller.dart';

class MainHomeAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainHomeAdminController>(
      () => MainHomeAdminController(),
    );
  }
}
