import 'dart:io';

import 'package:donor_darah/app/data/models/event_model.dart';
import 'package:donor_darah/app/services/event_services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FormEventController extends GetxController {
  FirebaseStorage storage = FirebaseStorage.instance;
  UploadTask? uploadTask;
  TextEditingController nameC = TextEditingController(text: '');
  TextEditingController addressC = TextEditingController(text: '');
  TextEditingController startController = TextEditingController(text: '');
  TextEditingController overController = TextEditingController(text: '');
  XFile? image;
  String? imgUrl;
  ImagePicker? _picker;

  @override
  void onInit() {
    _picker = ImagePicker();
    super.onInit();
  }

  Future<void> pickFromGalley() async {
    final XFile? img = await _picker!.pickImage(
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
    final XFile? img = await _picker!.pickImage(
      source: ImageSource.camera,
      imageQuality: 10,
    );

    if (img != null) {
      image = img;
      update();
      Get.back();
    }
  }

  void setName(String name) => nameC.text = name;
  void setAddress(String address) => addressC.text = address;

  Future<void> uploadFile() async {
    final path = 'images/${image?.name}';
    final file = File('${image?.path}');
    final ref = storage.ref().child(path);
    uploadTask = ref.putFile(file);
    final snapshot = await uploadTask!.whenComplete(() => {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    imgUrl = urlDownload;
  }

  Future<EventModel> addEvent() async {
    EventModel eventModel = EventModel(
        name: nameC.text,
        address: addressC.text,
        imgUrl: imgUrl,
        start: startController.text,
        over: overController.text);

    await EventServices().addEvent(event: eventModel);

    return eventModel;
  }
}
