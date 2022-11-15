import 'dart:io';

import 'package:donor_darah/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../controllers/form_event_controller.dart';

class FormEventView extends GetView<FormEventController> {
  FormEventView({Key? key}) : super(key: key);
  FormEventController controller = Get.put(FormEventController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFFCF0A0A),
          title: Text(
            'Pendaftaran Acara Donor\nDarah',
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
                      child: GetBuilder<FormEventController>(
                        builder: (controller) => controller.image != null
                            ? Container(
                                width: 110,
                                height: 110,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    image: DecorationImage(
                                        image: FileImage(
                                            File(controller.image!.path)),
                                        fit: BoxFit.cover)))
                            : Container(
                                width: 110,
                                height: 110,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/icons/pic.png')))),
                      )),
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
                        await controller.addEvent();
                        Get.offAllNamed(Routes.MAIN_HOME_ADMIN);
                        Get.snackbar(
                            'Sukses', 'Berhasil menambah acara donor darah',
                            backgroundColor: Colors.green);
                      });
                    } else {
                      await controller.addEvent();
                      Get.offAllNamed(Routes.MAIN_HOME_ADMIN);
                      Get.snackbar(
                          'Sukses', 'Berhasil menambah acara donor darah',
                          backgroundColor: Colors.green);
                    }
                    // Get.toNamed(Routes.MAIN_HOME_USER);
                  },
                  child: Text(
                    'save',
                    style:
                        GoogleFonts.poppins(color: Colors.white, fontSize: 20),
                  ),
                )
              ],
            ),
          ),
        )));
  }
}
