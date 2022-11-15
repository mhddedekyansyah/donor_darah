import 'package:donor_darah/app/modules/history/views/history_view.dart';
import 'package:donor_darah/app/modules/home/controllers/home_controller.dart';
import 'package:donor_darah/app/modules/home/views/home_view.dart';
import 'package:donor_darah/app/modules/location/views/location_view.dart';
import 'package:donor_darah/app/modules/profile/views/profile_view.dart';
import 'package:donor_darah/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/main_home_user_controller.dart';

class MainHomeUserView extends GetView<MainHomeUserController> {
  MainHomeUserView({Key? key}) : super(key: key);
  MainHomeUserController controller = Get.put(MainHomeUserController());
  HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainHomeUserController>(
      builder: (_) {
        return Scaffold(
          body: IndexedStack(
            index: controller.currentIndex.value,
            children: [
              HomeView(),
              HistoryView(),
              LocationView(),
              ProfileView()
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            notchMargin: 8,
            clipBehavior: Clip.antiAlias,
            shape: const CircularNotchedRectangle(),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: controller.currentIndex.value,
              selectedItemColor: const Color(0xFFCF0A0A),
              unselectedItemColor: Colors.grey,
              onTap: (int index) {
                controller.changeCurrentIndex(index);
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.history), label: 'History'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.location_on), label: 'Maps'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'Profile'),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.toNamed(Routes.FORM_DAFTAR_DONOR,
                  arguments: {"user": homeController.user});
            },
            elevation: 0,
            backgroundColor: const Color(0xFFCF0A0A),
            child: const Icon(Icons.add),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }
}
