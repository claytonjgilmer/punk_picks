// 2020 SPECIFIC
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:punk_picks/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MatchScoutPage extends StatefulWidget {
  _MatchScoutPageState createState() => _MatchScoutPageState();
}

class _MatchScoutPageState extends State<MatchScoutPage> {
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

  void submitForm(context) async {
    String matchType = formKey.currentState.value['matchType'];
    String matchNumber = formKey.currentState.value['matchNumber'].toString();
    String teamNumber = formKey.currentState.value['teamNumber'].toString();
    DocumentReference matchDocument = Firestore.instance
        .collection('rmd')
        .document(teamNumber + matchType + matchNumber);
    DocumentSnapshot snapshot = await matchDocument.get().catchError((e) {
      debugPrint('ERROR: ' + e.toString());
      debugPrint('FIRESTORE DOWNLOAD ERROR, CHECK YOUR CONNECTION');
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Download error, check your wifi or data connection'),
      ));
    });
    if (!snapshot.exists) {
      await matchDocument
          .setData(formKey.currentState.value)
          .then((_) => navigateHome(context))
          .catchError((e) {
        debugPrint('ERROR: ' + e.toString());
        debugPrint('FIRESTORE UPLOAD ERROR, CHECK YOUR CONNECTION');
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Upload error, check your wifi or data connection.'),
          duration: Duration(seconds: 10),
        ));
      });
    } else {
      debugPrint(
          'SCOUTING DATA ALREADY EXISTS IN FIRESTORE! HOW DID YOU MANAGE TO SCREW UP THIS BADLY?');
      Scaffold.of(context).showSnackBar(SnackBar(
        content:
            Text('Scouting results for this match and team already exist.'),
        duration: Duration(seconds: 10),
      ));
    }
  }

  void navigateHome(context) async {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('Successfully submitted scouting results!'),
      duration: Duration(seconds: 10),
      action: SnackBarAction(
        label: 'Home',
        onPressed: () {
          router.navigateTo(context, '/home',
              transition: TransitionType.nativeModal);
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    if (scoutName != null)
      return Scaffold(
          appBar: AppBar(
            title: Text('Match Scout Form'),
          ),
          body: Builder(
            // Builder necessary to allow Scaffold.of popup to alert user of form validation failure
            builder: (BuildContext context) {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(children: <Widget>[
                    FormBuilder(
                      key: formKey,
                      autovalidate: false,
                      initialValue: {
                        'scoutName': scoutName,
                        'matchType': 'qm',
                        // HACK: matchNumber and teamNumber attributes don't like being declared as int (FormBuilderTextField throws an error
                        // due to expecting a string), so commenting out and letting flutter infer datatype
                        //'matchNumber' : 0,
                        //'teamNumber' : 0,
                        'didCrossLineAuto': false,
                        'cellScoredL1Auto': 0,
                        'cellScoredL2Auto': 0,
                        'cellScoredL3Auto': 0,
                        'cellScoredL1': 0,
                        'cellScoredL2': 0,
                        'cellScoredL3': 0,
                        'didRotationControl': false,
                        'didPositionControl': false,
                        'didPlayDefense': false,
                        'didParkEndgame': false,
                        'didClimbEndgame': false,
                        'didBalanceEndgame': false,
                        'scoutNotes': '',
                      },
                      child: Column(
                        children: <Widget>[
                          Text(
                            'General',
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                          FormBuilderTextField(
                            attribute: 'scoutName',
                            decoration: InputDecoration(
                                labelText: 'Scout Name', hintText: scoutName),
                            validators: [
                              FormBuilderValidators.required(),
                            ],
                          ),
                          FormBuilderDropdown(
                            attribute: 'matchType',
                            decoration:
                                InputDecoration(labelText: 'Match Type'),
                            items: [
                              DropdownMenuItem(
                                value: 'qm',
                                child: Text('Qualification'),
                              ),
                              DropdownMenuItem(
                                value: 'qf',
                                child: Text('Quarterfinal'),
                              ),
                              DropdownMenuItem(
                                value: 'sf',
                                child: Text('Semifinal'),
                              ),
                              DropdownMenuItem(
                                value: 'f',
                                child: Text('Final'),
                              )
                            ],
                          ),
                          FormBuilderTextField(
                            attribute: 'matchNumber',
                            keyboardType: TextInputType.number,
                            decoration:
                                InputDecoration(labelText: 'Match Number'),
                            valueTransformer: (text) => num.tryParse(text),
                            validators: [
                              FormBuilderValidators.required(),
                              FormBuilderValidators.numeric(),
                              FormBuilderValidators.maxLength(2),
                            ],
                          ),
                          FormBuilderTextField(
                            attribute: 'teamNumber',
                            keyboardType: TextInputType.number,
                            decoration:
                                InputDecoration(labelText: 'Team Number'),
                            valueTransformer: (text) => num.tryParse(text),
                            validators: [
                              FormBuilderValidators.required(),
                              FormBuilderValidators.numeric(),
                              FormBuilderValidators.maxLength(4),
                            ],
                          ),
                          SizedBox(
                            height: 64,
                          ),
                          Text(
                            'Autonomous',
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                          FormBuilderCheckbox(
                            attribute: 'didCrossLineAuto',
                            label: Text('Did they cross the auto line?'),
                          ),
                          FormBuilderStepper(
                              attribute: 'cellScoredL1Auto',
                              decoration: InputDecoration(
                                  labelText: 'Cells scored on the low level.'),
                              min: 0),
                          FormBuilderStepper(
                              attribute: 'cellScoredL2Auto',
                              decoration: InputDecoration(
                                  labelText: 'Cells scored on the high level.'),
                              min: 0),
                          FormBuilderStepper(
                              attribute: 'cellScoredL3Auto',
                              decoration: InputDecoration(
                                  labelText:
                                      'Cells scored on the high level in the circle.'),
                              min: 0),
                          SizedBox(
                            height: 64,
                          ),
                          Text(
                            'Teleop',
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                          FormBuilderStepper(
                              attribute: 'cellScoredL1',
                              decoration: InputDecoration(
                                  labelText: 'Cells scored on the low level.'),
                              min: 0),
                          FormBuilderStepper(
                              attribute: 'cellScoredL2',
                              decoration: InputDecoration(
                                  labelText: 'Cells scored on the high level.'),
                              min: 0),
                          FormBuilderStepper(
                              attribute: 'cellScoredL3',
                              decoration: InputDecoration(
                                  labelText:
                                      'Cells scored on the high level in the circle.'),
                              min: 0),
                          FormBuilderCheckbox(
                            attribute: 'didRotationControl',
                            label: Text(
                                'Did they successfully execute rotation control?'),
                          ),
                          FormBuilderCheckbox(
                            attribute: 'didPositionControl',
                            label: Text(
                                'Did they successfully execute position control?'),
                          ),
                          FormBuilderCheckbox(
                            attribute: 'didPlayDefense',
                            label: Text(
                                'Did they play defense?'),
                          ),
                          SizedBox(
                            height: 64,
                          ),
                          Text(
                            'Endgame',
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                          FormBuilderCheckbox(
                            attribute: 'didParkEndgame',
                            label:
                                Text('Did they park in the rendezvous zone?'),
                          ),
                          FormBuilderCheckbox(
                            attribute: 'didClimbEndgame',
                            label:
                                Text('Did they climb in the rendezvous zone?'),
                          ),
                          FormBuilderCheckbox(
                            attribute: 'didBalanceEndgame',
                            label: Text(
                                'Did they successfully balance in the rendezvous zone?'),
                          ),
                          SizedBox(
                            height: 64,
                          ),
                          Text(
                            'Other',
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                          FormBuilderTextField(
                            attribute: 'scoutNotes',
                            decoration:
                                InputDecoration(labelText: 'Scout notes'),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      child: Text('Submit'),
                      onPressed: () {
                        formKey.currentState.save();
                        if (formKey.currentState.validate()) {
                          submitForm(context);
                        } else {
                          debugPrint('FORM IS INVALID!');
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'Make sure your form is correctly filled out!'),
                          ));
                        }
                      },
                    )
                  ]),
                ),
              );
            },
          ));
    else
      return Center(
        child: CircularProgressIndicator(),
      );
  }
}
