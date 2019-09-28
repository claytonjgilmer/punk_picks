// 2019 SPECIFIC
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:punk_picks/routes.dart';

class MatchScoutPage extends StatefulWidget {
  _MatchScoutPageState createState() => _MatchScoutPageState();
}

class _MatchScoutPageState extends State<MatchScoutPage> {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  void initState() {
    super.initState();
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
              transition: TransitionType.fadeIn);
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
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
                      'scoutName': '',
                      'matchType': 'qm',
                      // HACK: matchNumber and teamNumber attributes don't like being declared as int (FormBuilderTextField throws an error
                      // due to expecting a string), so commenting out and letting flutter infer datatype
                      //'matchNumber' : 0,
                      //'teamNumber' : 0,
                      'sandstormHabLevel': 1,
                      'sandstormHabSuccess': false,
                      'hatchScoredSandstorm': 0,
                      'cargoScoredSandstorm': 0,
                      'hatchScoredL1': 0,
                      'hatchScoredL2': 0,
                      'hatchScoredL3': 0,
                      'cargoScoredL1': 0,
                      'cargoScoredL2': 0,
                      'cargoScoredL3': 0,
                      'endgameHabLevel': 1,
                      'endgameHabSuccess': false,
                      'defenseQuality': 0,
                      'driveQuality': 0,
                      'scoutNotes': '',
                    },
                    child: Column(
                      children: <Widget>[
                        FormBuilderTextField(
                          attribute: 'scoutName',
                          decoration: InputDecoration(labelText: 'Scout Name'),
                          validators: [
                            FormBuilderValidators.required(),
                          ],
                        ),
                        FormBuilderDropdown(
                          attribute: 'matchType',
                          decoration: InputDecoration(labelText: 'Match Type'),
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
                          decoration: InputDecoration(labelText: 'Team Number'),
                          valueTransformer: (text) => num.tryParse(text),
                          validators: [
                            FormBuilderValidators.required(),
                            FormBuilderValidators.numeric(),
                            FormBuilderValidators.maxLength(4),
                          ],
                        ),
                        Divider(
                          thickness: 2,
                          height: 75,
                          color: Color.fromRGBO(0, 0, 0, 0),
                        ),
                        FormBuilderRadio(
                          attribute: 'sandstormHabLevel',
                          decoration:
                              InputDecoration(labelText: 'Starting HAB level'),
                          options: [
                            FormBuilderFieldOption(
                              value: 1,
                            ),
                            FormBuilderFieldOption(
                              value: 2,
                            )
                          ],
                        ),
                        FormBuilderCheckbox(
                          attribute: 'sandstormHabSuccess',
                          label:
                              Text('Successfully left HAB during sandstorm?'),
                        ),
                        FormBuilderStepper(
                          attribute: 'hatchScoredSandstorm',
                          decoration: InputDecoration(
                            labelText: 'Hatches scored during sandstorm'
                          ),
                        ),
                        FormBuilderStepper(
                          attribute: 'cargoScoredSandstorm',
                          decoration: InputDecoration(
                            labelText: 'Cargo scored during sandstorm'
                          ),
                        ),
                        Divider(
                          thickness: 2,
                          height: 75,
                          color: Color.fromRGBO(0, 0, 0, 0),
                        ),
                        FormBuilderStepper(
                          attribute: 'hatchScoredL1',
                          decoration: InputDecoration(
                              labelText: 'Hatches scored on L1'),
                        ),
                        FormBuilderStepper(
                            attribute: 'hatchScoredL2',
                            decoration: InputDecoration(
                                labelText: 'Hatches scored on L2')),
                        FormBuilderStepper(
                          attribute: 'hatchScoredL3',
                          decoration: InputDecoration(
                              labelText: 'Hatches scored on L3'),
                        ),
                        FormBuilderStepper(
                          attribute: 'cargoScoredL1',
                          decoration:
                              InputDecoration(labelText: 'Cargo scored on L1'),
                        ),
                        FormBuilderStepper(
                          attribute: 'cargoScoredL2',
                          decoration:
                              InputDecoration(labelText: 'Cargo scored on L2'),
                        ),
                        FormBuilderStepper(
                          attribute: 'cargoScoredL3',
                          decoration:
                              InputDecoration(labelText: 'Cargo scored on L3'),
                        ),
                        Divider(
                          thickness: 2,
                          height: 75,
                          color: Color.fromRGBO(0, 0, 0, 0),
                        ),
                        FormBuilderRadio(
                          attribute: 'endgameHabLevel',
                          decoration:
                              InputDecoration(labelText: 'Endgame HAB Level'),
                          options: [
                            FormBuilderFieldOption(
                              value: 0,
                            ),
                            FormBuilderFieldOption(
                              value: 1,
                            ),
                            FormBuilderFieldOption(
                              value: 2,
                            ),
                            FormBuilderFieldOption(
                              value: 3,
                            )
                          ],
                        ),
                        FormBuilderCheckbox(
                          attribute: 'endgameHabSuccess',
                          label: Text(
                              'Successful climb on HAB during endgame?'),
                        ),
                        Divider(
                          thickness: 2,
                          height: 75,
                          color: Color.fromRGBO(0, 0, 0, 0),
                        ),
                        FormBuilderStepper(
                          attribute: 'defenseQuality',
                          decoration: InputDecoration(
                            labelText: 'How well did they play defense? (0 if no defense)',
                          ),
                          validators: [
                            FormBuilderValidators.max(5)
                          ],
                        ),
                        FormBuilderStepper(
                          attribute: 'drivingQuality',
                          decoration: InputDecoration(
                            labelText: 'Rate their driving skills.'
                          ),
                          validators: [
                            FormBuilderValidators.max(5)
                          ],
                        ),
                        FormBuilderTextField(
                          attribute: 'scoutNotes',
                          decoration:
                              InputDecoration(labelText: 'Additional comments'),
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
  }
}
