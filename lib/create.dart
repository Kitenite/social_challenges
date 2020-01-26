import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:numberpicker/numberpicker.dart';
import 'events.dart';

class CreatePage extends StatelessWidget {
  Event event;
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
      body: _getInputs(context),

    );
  }

  Widget _getInputs(context){
    final _formKey = GlobalKey<FormState>();

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'What\'s your activity?',
                hintStyle: TextStyle(fontWeight: FontWeight.w300, fontSize: 20)
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            )),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Where will it take place?',
                hintStyle: TextStyle(fontWeight: FontWeight.w300, fontSize: 20)
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            )
      ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Number of attendees (1 to 100)',
                  hintStyle: TextStyle(fontWeight: FontWeight.w300, fontSize: 20)

              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter an integer';
                }
                return null;
              },
            )
        ),
            FlatButton(
                onPressed: () {
                  DatePicker.showDateTimePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(2018, 3, 5),
                      maxTime: DateTime(2019, 6, 7), onChanged: (date) {
                        print('change $date');
                      }, onConfirm: (date) {
                        print('confirm $date');
                      }, currentTime: DateTime.now(), locale: LocaleType.en);
                },
                child: Text(
                  'add event date',
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                )),
            Padding(
              padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 30.0),
              child: RaisedButton(
                onPressed: () {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (_formKey.currentState.validate()) {
                    // Process data.
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
