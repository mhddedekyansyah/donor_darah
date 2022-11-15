import 'package:get/get.dart';

import '../controllers/main_home_user_controller.dart';

class MainHomeUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainHomeUserController>(
      () => MainHomeUserController(),
    );
  }
}
