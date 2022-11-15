import 'package:donor_darah/app/modules/event/views/event_view.dart';
import 'package:donor_darah/app/modules/form_event/views/form_event_view.dart';
import 'package:donor_darah/app/modules/home_admin/views/home_admin_view.dart';
import 'package:donor_darah/app/modules/location/views/location_view.dart';
import 'package:donor_darah/app/modules/main_home_admin/controllers/main_home_admin_controller.dart';
import 'package:donor_darah/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class MainHomeAdminView extends GetView<MainHomeAdminController> {
  MainHomeAdminView({Key? key}) : super(key: key);
  MainHomeAdminController controller = Get.put(MainHomeAdminController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainHomeAdminController>(
      builder: (_) {
        return Scaffold(
          body: IndexedStack(
            index: controller.currentIndex.value,
            children: [HomeAdminView(), EventView()],
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
                    icon: Icon(Icons.notes), label: 'acara donor'),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.toNamed(Routes.FORM_EVENT);
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
