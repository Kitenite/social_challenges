import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'data.dart';

class EventsListPageState extends State<EventsListPage> {
  final List<Event> _events = <Event>[];

  var built = false;
  var _count = 0;

  @override
  Widget build(BuildContext context) {
    if (!built){
      findEvents();
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

  findEvents() {
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
      ds["location"], ds["score"],
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

    return ListTile(
      title: Text(
        event.title,
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EventPage(event:event, user:widget.user)),
        );
        // Push event page
      },
    );
  }
}

class EventsListPage extends StatefulWidget {
  User user;

  EventsListPage(User user) {
    this.user = user;
  }

  @override
  EventsListPageState createState() => EventsListPageState();

}

class Event {
  String title;
  String owner = "owner";
  GeoPoint location;
  String documentID;
  int score = 100;
  int maxAttendance = 5;
  int numAttending = 3;
  Timestamp date;


  Event(String title, String owner, GeoPoint location,
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

  create() {
    Firestore.instance.collection("challenge").document()
      .setData({'title': title, 'owner': owner,
        'max_attending': maxAttendance,
        'attending': numAttending, 'date': date,
        'score': score, 'location': location,
        'full': numAttending >= maxAttendance,
        'ppl': [owner]});
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
            return _buildRow(event.location.latitude.toString() + ", " + event.location.longitude.toString());
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
                _neverSatisfied(event);
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

  Future<void> _neverSatisfied(Event event) async {
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
                Firestore.instance.collection("users")
                  .document(widget.user.documentID).updateData({"upcoming": FieldValue.arrayUnion([event.documentID])});
                Firestore.instance.collection("challenge")
                  .document(event.documentID).updateData({
                  "attending": FieldValue.increment(1), "score": FieldValue.increment(widget.user.score),
                  "ppl": FieldValue.arrayUnion([widget.user.username])
                });
                Firestore.instance.collection("challenge")
                  .document(event.documentID).get().then((DocumentSnapshot ds) {
                    if (ds["attending"] >= ds["max_attending"]) {
                      Firestore.instance.collection("challenge")
                        .document(event.documentID).updateData({"full": true});
                    }
                  });

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
  final User user;
  EventPage({Key key, @required this.event, @required this.user}) : super(key: key);

  @override
  EventPageState createState() => EventPageState();

}
