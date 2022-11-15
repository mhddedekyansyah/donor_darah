import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor_darah/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Timer(const Duration(seconds: 3), () async {
      print('splash running');
      // Get.offAllNamed(Routes.REGISTER);
      User? user = FirebaseAuth.instance.currentUser;
      CollectionReference userRef =
          FirebaseFirestore.instance.collection('users');

      DocumentSnapshot data = await userRef.doc(user?.phoneNumber).get();
      if (data.data() != null) {
        Map<String, dynamic> role = data.data() as Map<String, dynamic>;

        if (role['role'] == 'ADMIN') {
          Get.offAllNamed(Routes.MAIN_HOME_ADMIN);
        } else {
          Get.offAllNamed(Routes.MAIN_HOME_USER);
        }
      } else {
        Get.offAllNamed(Routes.REGISTER);
      }
    });
    super.onInit();
  }

  // @override
  // void onInit() {
  //   debugPrint('Running');
  //   super.onInit();
  // }

  RxInt index = 1.obs;
}
