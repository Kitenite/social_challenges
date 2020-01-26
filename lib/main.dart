import 'package:flutter/material.dart';
import 'events.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Social App',
      home: Scaffold(
          body:Center(
            child: EventsList(),
          ),

      ),
    );
  }
}


