import 'package:donor_darah/app/data/models/pendaftaran_donor_model.dart';
import 'package:donor_darah/app/data/models/user_model.dart';
import 'package:donor_darah/app/services/daftar_donor_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormDaftarDonorController extends GetxController {
  final RxList<String> genderItems = [
    'Pria',
    'Wanita',
  ].obs;

  RxString? selectedValue = ''.obs;

  final formKey = GlobalKey<FormState>();

  final TextEditingController noKtpController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController motherNameController = TextEditingController();
  final TextEditingController jobController = TextEditingController();
  final TextEditingController ttlController = TextEditingController();

  void setNoKtp(String noKtp) => noKtpController.text = noKtp;
  void setName(String name) => nameController.text = name;
  void setAddress(String address) => addressController.text = address;
  void setMobile(String noHp) => mobileController.text = noHp;
  void setMotherName(String motherName) =>
      motherNameController.text = motherName;
  void setJob(String job) => jobController.text = job;

  Future<PendaftaranDonor> daftarDonor(UserModel? user) async {
    dynamic uid = FirebaseAuth.instance.currentUser?.phoneNumber;
    try {
      PendaftaranDonor dataDonor = PendaftaranDonor(
        userId: uid,
        noKtp: noKtpController.text,
        name: user?.name,
        address: user?.address,
        gender: selectedValue?.value,
        mobile: uid,
        motherName: motherNameController.text,
        job: jobController.text,
        ttl: ttlController.text,
      );
      await DaftarDonorServices().addPendaftaran(dataDonor);

      return dataDonor;
    } catch (e) {
      throw e;
    }
  }
}
