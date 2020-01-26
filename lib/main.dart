import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'events.dart';
import 'create.dart';
import 'login_page.dart';
import 'data_show.dart';

void main() => runApp(MainAppPage());

class MainAppPageState  extends State<MainAppPage> {

  User mainUser = new User();

  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    EventsListPage(),
    CreatePage(),
    DataShow(),
  ];

  @override
  Widget build(BuildContext context) {
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

