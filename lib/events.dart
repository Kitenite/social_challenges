import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'data.dart';
import 'package:intl/intl.dart';


class EventsListPageState extends State<EventsListPage> {
  final List<Event> _events = <Event>[];

  var built = false;
  var _count = 0;

  @override
  Widget build(BuildContext context) {
    if (!built){
      _findEvents();
      built = true;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
            'Events near you',
            style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30)),
      ),
      backgroundColor: Colors.white,

      body: _getEvents(),
    );
  }

  _findEvents() {
    print("find events");
    Firestore.instance.collection("challenge")
      //.where("date", isGreaterThanOrEqualTo: new DateTime.now())
      .where("full", isEqualTo: false)
      .snapshots()
      .listen((data) =>
        data.documents.forEach((doc) =>
          _addEvent(doc)));
  }

  _addEvent(DocumentSnapshot ds) {
    print(ds.documentID);
    if (ds["title"] == null) {return;}
    _events.add(new Event(ds["title"], ds["owner"],
      ds["location"].toString(), ds["score"],
      ds["max_attending"], ds["attending"],
      ds["date"], ds.documentID));
    // _getEvents();
    setState((){ _count = _events.length;});
  }

  Widget _getEvents() {
    print("get Events");
    print(_events.length);
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _events.length,
        itemBuilder: /*1*/ (context, i) {
          if (_events.length <= 0) {
            return Text("No Events");
          }
          print(_events[i].title);
          return _buildRow(_events[i]);
        });
  }

  Widget _buildRow(Event event){
    return VideoDescription(event:event);
  }
}

class EventsListPage extends StatefulWidget {
  EventsListPage();

  @override
  EventsListPageState createState() => EventsListPageState();
}

class Event {
  String title;
  String owner = "owner";
  String location = "Location";
  String documentID;
  int score = 100;
  int maxAttendance = 5;
  int numAttending = 3;
  Timestamp date;


  Event(String title, String owner, String location,
    int score, int maxAttendance, int numAttending,
    Timestamp date, String documentID) {
    print(title);
    this.title = title;
    this.owner = owner;
    this.location = location;
    this.score = score;
    this.maxAttendance = maxAttendance;
    this.numAttending = numAttending;
    this.date = date;
    this.documentID = documentID;
  }


  // Score, Owner, Max attendance, Location, Date, Number attending
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
          title: Text('Attend this event?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('If confirm, the owner will be notified of your attendance. There will be a penalty to your reputation for flaking.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Attend'),
              onPressed: () {
                Navigator.of(context).pop();
                //Confirm attendance here
              },
            ),
            FlatButton(
            child: Text('Cancel'),
            onPressed: () {
            Navigator.of(context).pop();
            })
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

class VideoDescription extends StatelessWidget {
  const VideoDescription({
    Key key,
    this.event,
  }) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context) {
    final dateString = DateFormat('EEEE, MMMM dd').format(event.date.toDate());

    return Container(
        margin: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 30.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(),
        ),
        child: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              event.title.toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 25.0,
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
            Text(
              event.location + " - " + dateString,
              style: const TextStyle(
                fontWeight: FontWeight.w200,
                fontSize: 15.0,
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
            RichText(
              text: new TextSpan(
                // Note: Styles for TextSpans must be explicitly defined.
                // Child text spans will inherit styles from parent
                style: new TextStyle(
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  new TextSpan(text: event.score.toString(), style: new TextStyle(fontSize: 50, fontWeight: FontWeight.w300)),
                  new TextSpan(text: ' points', style: new TextStyle(fontSize: 20)),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
            Text(
              event.numAttending.toString() + ' attending',
              style: const TextStyle(fontSize: 15.0),
            ),
          ],
        ),
    )
    );
  }
}


