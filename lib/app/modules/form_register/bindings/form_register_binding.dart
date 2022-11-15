import 'package:get/get.dart';

import '../controllers/form_register_controller.dart';

class FormRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FormRegisterController>(
      () => FormRegisterController(),
    );
  }
}
