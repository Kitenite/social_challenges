import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'events.dart';

void main() => runApp(EventsPage());

class EventsPage extends StatelessWidget {
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
