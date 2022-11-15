import 'dart:io';

import 'package:donor_darah/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../controllers/edit_event_controller.dart';

class EditEventView extends GetView<EditEventController> {
  const EditEventView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.nameC.text = controller.nameC.text.isNotEmpty
        ? controller.nameC.text
        : Get.arguments['event'].name;
    controller.addressC.text = controller.addressC.text.isNotEmpty
        ? controller.addressC.text
        : Get.arguments['event'].address;
    controller.startController.text = controller.startController.text.isNotEmpty
        ? controller.startController.text
        : Get.arguments['event'].start;

    controller.overController.text = controller.overController.text.isNotEmpty
        ? controller.overController.text
        : Get.arguments['event'].over;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFFCF0A0A),
          title: Text(
            'Edit Acara Donor\nDarah',
            style: GoogleFonts.poppins(),
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          width: Get.width,
          height: Get.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 24),
                  child: InkWell(
                      onTap: () {
                        Get.bottomSheet(Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(15),
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () async {
                                  await controller.pickFromCamera();
                                },
                                child: Row(
                                  children: const [
                                    Icon(Icons.camera),
                                    SizedBox(width: 10),
                                    Text('from camera')
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              InkWell(
                                onTap: () async {
                                  await controller.pickFromGalley();
                                },
                                child: Row(
                                  children: const [
                                    Icon(Icons.image),
                                    SizedBox(width: 10),
                                    Text('from gallery')
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ));
                      },
                      child: GetBuilder<EditEventController>(
                          builder: (controller) => controller.image != null
                              ? CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 65,
                                  backgroundImage:
                                      FileImage(File(controller.image!.path)))
                              : Get.arguments['event'].imgUrl != null &&
                                      Get.arguments['event'].imgUrl!.isNotEmpty
                                  ? CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      radius: 65,
                                      backgroundImage: NetworkImage(
                                          Get.arguments['event'].imgUrl))
                                  : const CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      radius: 65,
                                      backgroundImage:
                                          AssetImage('assets/icons/pic.png')))),
                ),
                const SizedBox(
                  height: 60,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tempat acara',
                      style: GoogleFonts.poppins(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      onChanged: (String name) {
                        controller.setName(name);
                      },
                      initialValue: controller.nameC.text,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                            borderSide: const BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                            borderSide: const BorderSide(color: Colors.black)),
                      ),
                      style: GoogleFonts.poppins(color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Alamat',
                      style: GoogleFonts.poppins(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      onChanged: (String address) {
                        controller.setAddress(address);
                      },
                      initialValue: controller.addressC.text,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                            borderSide: const BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                            borderSide: const BorderSide(color: Colors.black)),
                      ),
                      style: GoogleFonts.poppins(color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dimulai',
                      style: GoogleFonts.poppins(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      readOnly: true,
                      controller: controller.startController,
                      decoration: InputDecoration(
                        hintText: '00/00/00',
                        suffixIcon: const Icon(Icons.calendar_today),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                            borderSide: const BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                            borderSide: const BorderSide(color: Colors.grey)),
                      ),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(
                                2000), //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2101));

                        if (pickedDate != null) {
                          print(
                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          print(
                              formattedDate); //formatted date output using intl package =>  2021-03-16
                          //you can implement different kind of Date Format here according to your requirement
                          controller.startController.text =
                              formattedDate.toString();
                        } else {
                          print("Date is not selected");
                        }
                      },
                      style: GoogleFonts.poppins(color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Diakhiri',
                      style: GoogleFonts.poppins(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      readOnly: true,
                      controller: controller.overController,
                      decoration: InputDecoration(
                        hintText: '00/00/00',
                        suffixIcon: const Icon(Icons.calendar_today),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                            borderSide: const BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                            borderSide: const BorderSide(color: Colors.grey)),
                      ),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(
                                2000), //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2101));

                        if (pickedDate != null) {
                          print(
                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          print(
                              formattedDate); //formatted date output using intl package =>  2021-03-16
                          //you can implement different kind of Date Format here according to your requirement
                          controller.overController.text =
                              formattedDate.toString();
                        } else {
                          print("Date is not selected");
                        }
                      },
                      style: GoogleFonts.poppins(color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: const Color(0xFFCF0A0A),
                      minimumSize: const Size.fromHeight(45)),
                  onPressed: () async {
                    if (controller.image != null) {
                      await controller.uploadFile().then((_) async {
                        await controller.updateEvent(Get.arguments['event'],
                            Get.arguments['event'].imgUrl);
                        Get.offAllNamed(Routes.MAIN_HOME_ADMIN);
                        Get.snackbar(
                            'Sukses', 'Berhasil mengupdated acara donor darah',
                            backgroundColor: Colors.green);
                      });
                    } else {
                      await controller.updateEvent(Get.arguments['event'],
                          Get.arguments['event'].imgUrl);
                      Get.offAllNamed(Routes.MAIN_HOME_ADMIN);
                      Get.snackbar(
                          'Sukses', 'Berhasil mengupdated acara donor darah',
                          backgroundColor: Colors.green);
                    }
                    // Get.toNamed(Routes.MAIN_HOME_USER);
                  },
                  child: Text(
                    'save',
                    style:
                        GoogleFonts.poppins(color: Colors.white, fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        )));
  }
}
