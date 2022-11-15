import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor_darah/app/data/models/event_model.dart';

class EventServices {
  final CollectionReference _eventRef =
      FirebaseFirestore.instance.collection('events');

  Future addEvent({EventModel? event}) async {
    try {
      _eventRef.add({
        'name': event?.name,
        'address': event?.address,
        'imgUrl': event?.imgUrl,
        'start': event?.start,
        'over': event?.over
      }).then((_) => print('Events added'));
    } catch (e) {
      throw e;
    }
  }

  Future editEvent({EventModel? event}) async {
    try {
      _eventRef.doc(event?.id).set({
        'name': event?.name,
        'address': event?.address,
        'imgUrl': event?.imgUrl,
        'start': event?.start,
        'over': event?.over
      }).then((_) => print('Events Updated'));
    } catch (e) {
      throw e;
    }
  }
}
