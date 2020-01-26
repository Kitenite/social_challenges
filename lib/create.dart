import 'package:flutter/material.dart';
import 'events.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreatePage extends StatelessWidget {
  CreatePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
            'Create your event',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30)),
      ),
      backgroundColor: Colors.white,
      body: _getInputs(),

    );
  }

  Widget _getInputs(){
    final _formKey = GlobalKey<FormState>();
    var _title;
    var _date;
    var _time;
    var _location;
    var _maxAttend;


    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Event title',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
              },
              onSaved: (value) {
                _title = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Date (MM/DD/YY)',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
              },
              onSaved: (value) {
                _date = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Time (00:00)',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
              },
              onSaved: (value) {
                _time = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Location (latitude, long)',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
              },
              onSaved: (value) {
                _location = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Max attendance (1...999)',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
              },
              onSaved: (value) {
                _maxAttend = value;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                onPressed: () {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    var _day = _date.replaceAll(RegExp('/'), '');
                    var _clock = _time + ":00";
                    var _bits = _location.split(",");
                    var myEvent = new Event(_title, "owner",
                      new GeoPoint(double.parse(_bits[0]), double.parse(_bits[1])),
                      10, int.parse(_maxAttend), 1,
                      Timestamp.fromDate(DateTime.parse(_day + " " + _clock)),
                      "fakeid");
                    myEvent.create();
                  }
                },
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      )
    );
  }

}
