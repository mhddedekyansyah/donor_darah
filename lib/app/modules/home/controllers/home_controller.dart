import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor_darah/app/data/models/event_model.dart';
import 'package:donor_darah/app/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  UserModel? user;

  Stream<List<EventModel>> fetchEvent() async* {
    dynamic uid = FirebaseAuth.instance.currentUser?.phoneNumber;
    try {
      dynamic events = FirebaseFirestore.instance
          .collection('events')
          // .doc(FirebaseAuth.instance.currentUser!.phoneNumber)
          // .where('userId', isEqualTo: uid)
          .snapshots()
          .map((data) => data.docs
              .map((doc) => EventModel.fromJson(
                  doc.id, doc.data() as Map<String, dynamic>))
              .toList());

      yield* events;
    } catch (e) {
      throw e;
    }
  }

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
}
