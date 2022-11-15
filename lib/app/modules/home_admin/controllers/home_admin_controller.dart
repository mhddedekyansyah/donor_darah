import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor_darah/app/data/models/pendaftaran_donor_model.dart';
import 'package:donor_darah/app/data/models/user_model.dart';
import 'package:donor_darah/app/services/daftar_donor_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeAdminController extends GetxController {
  UserModel? user;

  Future logout() => FirebaseAuth.instance.signOut();

  Stream<UserModel> fetchUser() async* {
    try {
      var user = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.phoneNumber)
          // .doc('+6281997008336')
          .snapshots()
          .map((doc) =>
              UserModel.fromJson(doc.id, doc.data() as Map<String, dynamic>));
      user = user;
      yield* user;
    } catch (e) {
      throw e;
    }
  }

  Stream<List<PendaftaranDonor>> fetchPendaftarDonor() async* {
    dynamic uid = FirebaseAuth.instance.currentUser?.phoneNumber;
    try {
      dynamic daftarDonors = FirebaseFirestore.instance
          .collection('daftar_donors')
          // .doc(FirebaseAuth.instance.currentUser!.phoneNumber)
          // .where('userId', isEqualTo: uid)
          .snapshots()
          .map((data) => data.docs
              .map((doc) => PendaftaranDonor.fromJson(
                  doc.id, doc.data() as Map<String, dynamic>))
              .toList());

      yield* daftarDonors;
    } catch (e) {
      throw e;
    }
  }

  Future<PendaftaranDonor> tolak(PendaftaranDonor? donors) async {
    PendaftaranDonor donor = donors!.copyWith(
        userId: donors.userId,
        noKtp: donors.noKtp,
        name: donors.name,
        address: donors.address,
        gender: donors.gender,
        motherName: donors.motherName,
        mobile: donors.mobile,
        job: donors.job,
        ttl: donors.ttl,
        status: 'CANCEL');

    await DaftarDonorServices().updateStatus(donors: donor);

    return donor;
  }

  Future<PendaftaranDonor> terima(PendaftaranDonor? donors) async {
    PendaftaranDonor donor = donors!.copyWith(
        userId: donors.userId,
        noKtp: donors.noKtp,
        name: donors.name,
        address: donors.address,
        gender: donors.gender,
        motherName: donors.motherName,
        mobile: donors.mobile,
        job: donors.job,
        ttl: donors.ttl,
        status: 'KONFIR');

    await DaftarDonorServices().updateStatus(donors: donor);

    return donor;
  }
}
