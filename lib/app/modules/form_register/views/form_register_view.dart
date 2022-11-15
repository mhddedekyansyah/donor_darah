import 'dart:io';

import 'package:donor_darah/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/form_register_controller.dart';

class FormRegisterView extends GetView<FormRegisterController> {
  const FormRegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      padding: const EdgeInsets.all(30),
      width: Get.width,
      height: Get.height,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
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
                child: GetBuilder<FormRegisterController>(
                  builder: (controller) => controller.image != null
                      ? Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              image: DecorationImage(
                                  image:
                                      FileImage(File(controller.image!.path)),
                                  fit: BoxFit.cover)))
                      : Container(
                          width: 110,
                          height: 110,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/icons/pic.png')))),
                )),
            const SizedBox(
              height: 60,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nama Lengkap',
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
                  'No. Handphone',
                  style: GoogleFonts.poppins(fontSize: 18),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  readOnly: true,
                  initialValue: Get.arguments?['noHp'] ?? '',
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
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
                  style: GoogleFonts.poppins(color: Colors.black),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            MaterialButton(
              onPressed: () async {
                if (controller.image != null) {
                  await controller.uploadFile().then((_) async {
                    await controller.addUser();
                    Get.offAllNamed(Routes.MAIN_HOME_USER);
                  });
                } else {
                  await controller.addUser();
                  Get.offAllNamed(Routes.MAIN_HOME_USER);
                }
                // Get.toNamed(Routes.MAIN_HOME_USER);
              },
              child: Text(
                'lanjutkan',
                style: GoogleFonts.poppins(color: Colors.black, fontSize: 20),
              ),
            )
          ],
        ),
      ),
    )));
  }
}
