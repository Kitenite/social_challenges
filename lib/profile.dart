import 'package:flutter/material.dart';
import 'data.dart';

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
        title: Text(
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
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: 2,
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
}
