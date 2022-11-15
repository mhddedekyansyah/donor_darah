import 'package:get/get.dart';

import '../controllers/form_daftar_donor_controller.dart';

class FormDaftarDonorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FormDaftarDonorController>(
      () => FormDaftarDonorController(),
    );
  }
}
