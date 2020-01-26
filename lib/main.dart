import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'events.dart';
import 'login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Social App',
      home: new SignInPage(),
      // home: Scaffold(
      //     body:Center(
      //       child: EventsList(),
      //     ),
      //),
    );
  }
}
