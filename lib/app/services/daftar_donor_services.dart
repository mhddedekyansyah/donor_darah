import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor_darah/app/data/models/pendaftaran_donor_model.dart';

class DaftarDonorServices {
  final CollectionReference _donorRef =
      FirebaseFirestore.instance.collection('daftar_donors');

  Future addPendaftaran(PendaftaranDonor donor) async {
    try {
      _donorRef.add({
        'userId': donor.mobile,
        'noKtp': donor.noKtp,
        'name': donor.name,
        'address': donor.address,
        'gender': donor.gender,
        'mobile': donor.mobile,
        'motherName': donor.motherName,
        'job': donor.job,
        'TTL': donor.ttl,
        'status': donor.status
      }).then((value) => print('added daftar donor'));
    } catch (e) {
      throw e;
    }
  }

  Future updateStatus({PendaftaranDonor? donors}) async {
    CollectionReference donor =
        FirebaseFirestore.instance.collection('daftar_donors');

    try {
      return donor
          .doc(donors?.id)
          .update({
            'userId': donors?.userId,
            'noKtp': donors?.noKtp,
            'name': donors?.name,
            'address': donors?.address,
            'gender': donors?.gender,
            'mobile': donors?.mobile,
            'motherName': donors?.motherName,
            'job': donors?.job,
            'TTL': donors?.ttl,
            'status': donors?.status
          })
          .then((_) => print("Status Updated"))
          .catchError((error) => print("Failed to update status: $error"));
    } catch (e) {
      throw e;
    }
  }
}
