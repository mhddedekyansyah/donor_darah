import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor_darah/app/data/models/event_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class EventController extends GetxController {
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

  Future deleteEvent(dynamic uid) {
    CollectionReference events =
        FirebaseFirestore.instance.collection('events');
    return events.doc(uid).delete().then((_) => print('Event Deleted'));
  }
}
