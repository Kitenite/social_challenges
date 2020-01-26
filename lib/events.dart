import 'package:flutter/material.dart';

class EventsListState extends State<EventsList> {

  final List<Event> _events = <Event>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Events near you'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushEventPage),
        ], // ... to here.
      ),
      body: _getEvents(),
    );
  }

  void _pushEventPage(){}

  Widget _getEvents() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider();
          /*2*/
          final index = i ~/ 2; /*3*/

          return _buildRow(_events[index]);
        });
  }

  Widget _buildRow(Event event){

    return ListTile(
      title: Text(
        event.title,
      ),
      onTap: () {
        // Push event page
      },
    );
  }
}

class EventsList extends StatefulWidget {
  @override
  EventsListState createState() => EventsListState();
}

class Event {
  String title;
  // Score, Owner, Max attendance, Location, Date, Number attending
}

// Profile: Score, username, list of upcoming challenges, past challenges and challenges they own