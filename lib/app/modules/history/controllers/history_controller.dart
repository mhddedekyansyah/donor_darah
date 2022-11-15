import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor_darah/app/data/models/pendaftaran_donor_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController {
  PendaftaranDonor? daftarDonors;

  Stream<List<PendaftaranDonor>> fetchDaftarDonor() async* {
    dynamic uid = FirebaseAuth.instance.currentUser?.phoneNumber;
    try {
      dynamic daftarDonors = FirebaseFirestore.instance
          .collection('daftar_donors')
          // .doc(FirebaseAuth.instance.currentUser!.phoneNumber)
          .where('userId', isEqualTo: uid)
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
}
