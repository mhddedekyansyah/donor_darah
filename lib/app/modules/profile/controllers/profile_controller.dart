import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor_darah/app/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  UserModel? user;

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

  Future logout() => FirebaseAuth.instance.signOut();
}
