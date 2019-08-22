import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class MatchScoutPage extends StatefulWidget {
  _MatchScoutPageState createState() => _MatchScoutPageState();
}

class _MatchScoutPageState extends State<MatchScoutPage> {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Match Scout Form'),),
      body: SingleChildScrollView( 
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            children: <Widget>[
              FormBuilder(
              key: formKey,
              autovalidate: true,
              initialValue: {
                'scoutName' : '',
                'matchType' : 'q',
                // HACK: matchNumber and teamNumber attributes don't like being declared as int (FormBuilderTextView throws an error 
                // due to expecting a string), so commenting out and letting flutter infer datatype
                //'matchNumber' : 0,
                //'teamNumber' : 0,
                'sandstormHabLevel' : 1,
                'sandstormHabSuccess' : false,
                'hatchScoredL1' : 0,
                'hatchScoredL2' : 0,
                'hatchScoredL3' : 0,
                'cargoScoredL1' : 0,
                'cargoScoredL2' : 0,
                'cargoScoredL3' : 0,
                'endgameHabLevel' : 1,
                'endgameHabSuccess' : false,
                'rocketRP' : false,
                'climbRP' : false,
                'scoutNotes' : '',
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
                        value: 'q',
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
                    decoration: InputDecoration(labelText: 'Match Number'),
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
                  FormBuilderRadio(
                    attribute: 'sandstormHabLevel',
                    decoration: InputDecoration(labelText: 'Starting HAB level'),
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
                    label: Text('Successfully left HAB during sandstorm?'),
                  ),
                  FormBuilderStepper(
                    attribute: 'hatchScoredL1',
                    decoration: InputDecoration(labelText: 'Hatches scored on L1'),
                  ),
                  FormBuilderStepper(
                    attribute: 'hatchScoredL2',
                    decoration: InputDecoration(labelText: 'Hatches scored on L2')
                  ),
                  FormBuilderStepper(
                    attribute: 'hatchScoredL3',
                    decoration: InputDecoration(labelText: 'Hatches scored on L3'),
                  ),
                  FormBuilderStepper(
                    attribute: 'cargoScoredL1',
                    decoration: InputDecoration(labelText: 'Cargo scored on L1'),
                  ),
                  FormBuilderStepper(
                    attribute: 'cargoScoredL2',
                    decoration: InputDecoration(labelText: 'Cargo scored on L2'),
                  ),
                  FormBuilderStepper(
                    attribute: 'cargoScoredL3',
                    decoration: InputDecoration(labelText: 'Cargo scored on L3'),
                  ),
                  FormBuilderRadio(
                    attribute: 'endgameHabLevel',
                    decoration: InputDecoration(labelText: 'Endgame HAB Level'),
                    options: [
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
                    label: Text('Successfully parked on HAB during endgame?'),
                  ),
                  FormBuilderTextField(
                    attribute: 'scoutNotes',
                    decoration: InputDecoration(labelText: 'Additional comments'),
                  )
                ],
              ),
            ),
        ),
      ),
    );
  }
}