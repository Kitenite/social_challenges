import 'package:flutter/material.dart';
import 'data.dart';

class DataShow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final datum = new Data();
    datum.getAll();
    return Text("Hello World");
  }
}
