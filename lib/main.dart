import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'events.dart';
import 'create.dart';
import 'login_page.dart';
import 'profile.dart';
import 'data.dart';


void main() => runApp(MainAppPage());

class MainAppPageState  extends State<MainAppPage> {
  Data data= Data();
  static User user;
  var built = false;
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions;

  @override
  Widget build(BuildContext context) {
    if(!built){
      data.getUserInfo("perak005@umn.edu").listen((data) =>
          data.documents.forEach((doc) =>
          //self = new User(doc["username"], doc["score"])
          setState(() {
            user = new User(doc["username"], doc["score"]);
            _widgetOptions = <Widget>[
              EventsListPage(),
              CreatePage(),
              ProfilePage(user),
            ];
          })
          ));
      built = true;
    }

    user = data.self;
    return MaterialApp(
      title: 'Social App',
      home: Scaffold(
        body:Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.local_activity),
              title: Text('Events'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle),
              title: Text('Create'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              title: Text('Profile'),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class MainAppPage extends StatefulWidget{
  @override
  MainAppPageState createState() => MainAppPageState();

}

