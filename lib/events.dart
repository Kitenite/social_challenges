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
    final fakeEvent = new Event("Event number 1");
    _events.add(fakeEvent);
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _events.length,
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) {
            return Divider();
          }else{
            if (_events.length <= 0) {
              return Text("No Events");
            }
            return _buildRow(_events[i]);
          }
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

  Event(String title){
    this.title = title;
  }

  // Score, Owner, Max attendance, Location, Date, Number attending
}

// Profile: Score, username, list of upcoming challenges, past challenges and challenges they own
