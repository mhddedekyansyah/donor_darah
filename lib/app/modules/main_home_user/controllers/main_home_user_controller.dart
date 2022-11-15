import 'package:get/get.dart';

class MainHomeUserController extends GetxController {
  RxInt currentIndex = 0.obs;

  dynamic changeCurrentIndex(int index) {
    currentIndex.value = index;
    update();
  }
}
