import 'package:flutter/material.dart';
import 'package:social_app/events.dart';

class Person {
  String name;
  List pastEvents;
  List upcomingEvents;
  List ownedEvents;
}

class ProfilePageState extends State<ProfilePage> {
  final Path<Person> people = <Person>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile')
      ),
      body: _getOptions(),
    );
  }

  Widget _getOptions() {
    final List<String> entries = <String>['Name', 'Phone Number', 'Past Events','Upcoming Events','Hosted Events'];
    final List<int> colorCodes = <int>[600, 600, 600];

    ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 50,
            color: Colors.blue[colorCodes[index]],
            child: Center(child: Text('Entry ${entries[index]}')),
          );
        }
    );
        });
  }

}

class ProfilePage extends StatefulWidget {
@override
ProfilePageState createState() => ProfilePageState();
}