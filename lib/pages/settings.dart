import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class SettingsPage extends StatefulWidget {
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  SharedPreferences preferences;
  String scoutName;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      preferences = prefs;
      scoutName = prefs.getString('scoutName');
      setState((){});
    });
  }

  void saveScoutName(BuildContext context) {
    preferences.setString('scoutName', formKey.currentState.value['scoutName']);
    setState((){});
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('Successfully saved settings.'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    if (scoutName != null)
      return new Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: Builder(
          builder: (BuildContext context) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: <Widget>[
                    FormBuilder(
                      key: formKey,
                      autovalidate: false,
                      initialValue: {
                        'scoutName': scoutName,
                      },
                      child: Column(
                        children: <Widget>[
                          FormBuilderTextField(
                            attribute: 'scoutName',
                            decoration: InputDecoration(labelText: 'Scout Name', hintText: scoutName),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      child: Text('Save'),
                      onPressed: () {
                        formKey.currentState.save();
                        if (formKey.currentState.validate()) {
                          saveScoutName(context);
                        }
                      },
                    )
                  ],
                ),
              ),
            );
          },
        )
      );
      else 
        return Center(child: CircularProgressIndicator(),);
  }
}