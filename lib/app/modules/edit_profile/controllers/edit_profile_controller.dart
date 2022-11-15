import 'dart:io';

import 'package:donor_darah/app/data/models/user_model.dart';
import 'package:donor_darah/app/services/user_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  final user = FirebaseAuth.instance.currentUser;
  final storage = FirebaseStorage.instance;
  String? imgUrl;
  UploadTask? uploadTask;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();

  XFile? image;
  ImagePicker? _picker;

  @override
  void onInit() {
    _picker = ImagePicker();
    super.onInit();
  }

  Future<void> pickFromGalley() async {
    final XFile? img = await _picker?.pickImage(
      source: ImageSource.gallery,
      imageQuality: 10,
    );

    if (img != null) {
      image = img;
      update();
      Get.back();
    }
  }

  Future<void> pickFromCamera() async {
    final XFile? img = await _picker?.pickImage(
      source: ImageSource.camera,
      imageQuality: 10,
    );

    if (img != null) {
      image = img;
      update();
      Get.back();
    }
  }

  void setName(String name) => nameController.text = name;
  void setAddress(String address) => addressController.text = address;

  Future<void> uploadFile() async {
    final path = 'images/${image?.name}';
    final file = File('${image?.path}');
    final ref = storage.ref().child(path);
    uploadTask = ref.putFile(file);
    final snapshot = await uploadTask!.whenComplete(() => {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    imgUrl = urlDownload;
  }

  Future<UserModel> addUser({String? img}) async {
    try {
      UserModel userModel = UserModel().copyWith(
          id: user?.phoneNumber,
          name: nameController.text,
          address: addressController.text,
          role: 'USER',
          photoUrl: imgUrl ?? img,
          mobile: user?.phoneNumber);
      await UserServices().setUser(userModel);

      return userModel;
    } catch (e) {
      throw e;
    }
  }
}
