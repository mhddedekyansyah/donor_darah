import 'dart:io';

import 'package:donor_darah/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.nameController.text = controller.nameController.text.isNotEmpty
        ? controller.nameController.text
        : Get.arguments['user'].name;
    controller.addressController.text =
        controller.addressController.text.isNotEmpty
            ? controller.addressController.text
            : Get.arguments['user'].address;
    controller.mobileController.text = Get.arguments['user'].mobile;
    Widget header() {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Image.asset(
                  'assets/icons/arrow_back.png',
                  width: 26,
                  height: 26,
                )),
            Text(
              'Edit Profile',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
            ),
            const SizedBox()
          ],
        ),
      );
    }

    Widget content() {
      return Container(
          child: Column(children: [
        Center(
          child: Stack(children: [
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    )),
                    builder: (context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Center(
                              child: Container(
                                margin: const EdgeInsets.only(top: 5),
                                width: 35,
                                height: 5,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10, left: 10),
                              child: GestureDetector(
                                onTap: () async {
                                  await controller.pickFromCamera();
                                },
                                child: Row(
                                  children: [
                                    const Icon(Icons.camera_alt),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      'camera',
                                      style: GoogleFonts.poppins(),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, top: 20, bottom: 10),
                              child: GestureDetector(
                                onTap: () async {
                                  await controller.pickFromGalley();
                                },
                                child: Row(
                                  children: [
                                    const Icon(
                                        Icons.photo_size_select_actual_rounded),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      'gallery',
                                      style: GoogleFonts.poppins(),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              },
              child: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(100)),
                  child: GetBuilder<EditProfileController>(
                    builder: (controller) => controller.image != null
                        ? CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 65,
                            backgroundImage:
                                FileImage(File(controller.image!.path)))
                        : Get.arguments['user'].photoUrl != null &&
                                Get.arguments['user'].photoUrl!.isNotEmpty
                            ? CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 65,
                                backgroundImage: NetworkImage(
                                    Get.arguments['user'].photoUrl))
                            : const CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 65,
                                backgroundImage: AssetImage(
                                    'assets/icons/user_photo_null.png')),
                  )),
            ),
            Positioned(
                bottom: 2,
                right: 12,
                child: Image.asset(
                  'assets/icons/add_foto.png',
                  width: 30,
                  height: 30,
                ))
          ]),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
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
                    initialValue: controller.nameController.text,
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
                    initialValue: controller.addressController.text,
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
                    initialValue: controller.mobileController.text,
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(45),
                    primary: Colors.green),
                onPressed: () async {
                  if (controller.image != null) {
                    await controller.uploadFile().then((_) async {
                      await controller.addUser();
                    });
                  } else {
                    await controller.addUser(
                        img: Get.arguments['user'].photoUrl);
                  }
                  Get.back();
                  Get.snackbar('Sukses', 'Update Profile',
                      backgroundColor: Colors.green);
                },
                child: Text(
                  'save',
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 20),
                ),
              )
            ],
          ),
        )
      ]));
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
            child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [header(), content()],
          ),
        )),
      ),
    );
  }
}
