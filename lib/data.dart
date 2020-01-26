import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:core';
import 'dart:async';

class Data {
  User self;

  void getAll() {
    Firestore.instance.collection("challenge").getDocuments().then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => print('${f.data}'));
    });
  }

  Stream<QuerySnapshot> getAvailableChallenges() {
    return Firestore.instance.collection("challenge")
      .where("date", isGreaterThanOrEqualTo: new DateTime.now())
      .where("full", isEqualTo: false)
      .snapshots();
  }

  getUserInfo(String email) {
    return Firestore.instance.collection("users")
      .where("email", isEqualTo: email)
      .snapshots();
  }
}

class User {
  String username;
  int score;
  String documentID;
  List upcomingChallenges;
  List pastChallenges;
  List ownedChallenges;

  User(String username, int score, String docID) {
    print("Update user");
    this.username = username;
    this.score = score;
    this.documentID = docID;
  }
}
