import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'events.dart';

void main() => runApp(MainAppPage());

class MainAppPageState  extends State<MainAppPage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    EventsListPage(),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
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
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              title: Text('Business'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              title: Text('School'),
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

