import 'package:flutter/material.dart';

class EventsListState extends State<EventsList> {
  final fakeEvent = new Event("Event number 1");
  final fakeEvent2 = new Event("Event number 2");
  final fakeEvent3 = new Event("Event number 3");

  final List<Event> _events = <Event>[];

  @override
  Widget build(BuildContext context) {
    _events.add(fakeEvent);
    _events.add(fakeEvent2);
    _events.add(fakeEvent3);

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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EventPage(event:event)),
        );
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
  String owner = "owner";
  String location = "Location";
  int score = 100;
  int maxAttendance = 5;
  int numAttending = 3;
  DateTime date = DateTime.now();


  Event(String title){
    this.title = title;
  }

  // Score, Owner, Max attendance, Location, Date, Number attending
}

class User {
  String username;
  List upcomingChallenges;
  List pastChallenges;
  List ownedChallenges;
}

// Profile: Score, username, list of upcoming challenges, past challenges and challenges they own

class EventPageState extends State<EventPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page View"),
      ),
      body: Center(
        child: displayEvent(widget.event),
      ),
    );
  }

  Widget displayEvent(Event event){
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: 8,
        itemBuilder: /*1*/ (context, i) {
          if(i==0){
            return _buildRow(event.title);
          }
          else if (i==1){
            return _buildRow(event.owner);
          }
          else if (i==2){
            return _buildRow(event.location);
          }
          else if (i==3){
            return _buildRow(event.date);
          }
          else if (i==4){
            return _buildRow(event.score);
          }
          else if (i==5){
            return _buildRow(event.numAttending);
          }
          else if (i==6){
            return _buildRow(event.maxAttendance);
          }
          else {
            return RaisedButton(
              onPressed: () {
                _neverSatisfied();
              },
              child: Text(
                "Attend Event",
              ),
            );
          }
        });
  }

  Widget _buildRow(item){
    return ListTile(
      title: Text(item.toString())
    );
  }

  Future<void> _neverSatisfied() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Rewind and remember'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You will never be satisfied.'),
                Text('You\’re like me. I’m never satisfied.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Regret'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}

class EventPage extends StatefulWidget{
  final Event event;
  EventPage({Key key, @required this.event}) : super(key: key);

  @override
  EventPageState createState() => EventPageState();

}