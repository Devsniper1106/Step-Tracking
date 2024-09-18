import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_step_tracking/utils/date_time.dart';
import 'package:flutter/foundation.dart';

class FirestoreRepository {
  var email = FirebaseAuth.instance.currentUser?.email;

  Future<void> uploadStep(int step) {
    CollectionReference steps =
        FirebaseFirestore.instance.collection(getDailyCollectionName());
    return steps
        .doc(email)
        .set({"email": email, "step": step})
        .then((value) => print("Step info uploaded"))
        .catchError((error) => print("Failed to upload step info: $error"));
  }

  Future<QuerySnapshot> getSteps() {
    CollectionReference steps =
        FirebaseFirestore.instance.collection(getDailyCollectionName());
    return steps.orderBy("step", descending: true).limit(10).get();
  }

  Future<DocumentSnapshot> getStep() {
    debugPrint("get doc data");
    CollectionReference steps =
        FirebaseFirestore.instance.collection(getDailyCollectionName());
    return steps.doc(email).get().then((doc) {
      debugPrint("get doc data $doc");
      return doc;
    });
  }

  Stream<QuerySnapshot> getStepStream() {
    return FirebaseFirestore.instance
        .collection(getDailyCollectionName())
        .orderBy("step", descending: true)
        .limit(10)
        .snapshots();
  }
}
