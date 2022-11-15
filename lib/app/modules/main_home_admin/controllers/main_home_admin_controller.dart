import 'package:get/get.dart';

class MainHomeAdminController extends GetxController {
  RxInt currentIndex = 0.obs;

  dynamic changeCurrentIndex(int index) {
    currentIndex.value = index;
    update();
  }
}
