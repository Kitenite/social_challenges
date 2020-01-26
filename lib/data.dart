import 'package:cloud_firestore/cloud_firestore.dart';

class Data {
  void getAll() {
    Firestore.instance.collection("users").getDocuments().then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => print('${f.data}'));
    });
  }
}
