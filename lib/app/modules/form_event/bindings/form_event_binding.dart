import 'package:get/get.dart';

import '../controllers/form_event_controller.dart';

class FormEventBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FormEventController>(
      () => FormEventController(),
    );
  }
}
