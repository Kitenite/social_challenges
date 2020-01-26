import 'package:flutter/material.dart';
import 'data.dart';
import 'events.dart';


class ProfilePage extends StatelessWidget {

  User user;

  ProfilePage(User user){
    this.user = user;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title:  Text(
            user.username,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30)),
      ),
      backgroundColor: Colors.white,
      body: _getEvents(),
    );
  }

  Widget _getEvents() {
    return
      ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: 5,
        itemBuilder: /*1*/ (context, i) {
          switch (i){
            case 0: {
             return _buildRow(user.username);
            }
            break;
            case 1: {
              return _buildRow(user.score.toString());
            }
            break;
            case 2: {
              if (user.pastChallenges != null) {
                return _listChallenges(user.pastChallenges);
              } else{
                return _listChallenges([]);
              }
            }
            break;
            case 3: {
              return _buildRow(user.score.toString());
            }
            break;

            default: {
              return _buildRow(user.username);
            }
            break;
          }


        });
    }

  Widget _buildRow(item){
    return ListTile(
      title: Text(item)
    );
  }
  Widget _listChallenges(List<Event> items){
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: items.length,
        itemBuilder: /*1*/ (context, i) {
          if (items.length <= 0) {
            return Text("No Events");
          }
          print(items[i].title);
          return buildChallenge(items[i]);
        });
  }
  Widget buildChallenge(Event event){
    return VideoDescription(event:event);
  }
}
