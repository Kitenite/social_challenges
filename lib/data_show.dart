import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'data.dart';

class DataShow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final datum = new Data();
    datum.getUserInfo("perak005@umn.edu");
    return Text("Hello World");
  }
}
