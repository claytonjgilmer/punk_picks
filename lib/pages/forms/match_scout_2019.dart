import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:punk_picks/models/model_match_2019.dart';
import 'package:punk_picks/components/counter_form_field.dart';
import 'package:punk_picks/components/number_form_field.dart';

class MatchScoutPage extends StatefulWidget {
  _MatchScoutPageState createState() => _MatchScoutPageState();
}

class _MatchScoutPageState extends State<MatchScoutPage> {
  final formKey = GlobalKey<FormState>();
  ModelMatch2019 matchData;

  void initState() {
    super.initState();
    // Set default match and game states
    matchData = ModelMatch2019(
      scoutName: '',
      matchType: 'q',
      matchNumber: 1,
      allianceColor: 'r',
      scoutNotes: '',
      sandstormHabLevel: 1,
      sandstormHabSuccess: false,
      hatchesDuringSandstorm: 0,
      cargoDuringSandstorm: 0,
      hatchesDuringTeleop: 0,
      cargoDuringTeleop: 0,
      endgameHabLevel: 1,
      climbRP: false,
      rocketRP: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Match Scout Form')
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(40),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              // Begin game-agnostic form section
              TextFormField(
                decoration: InputDecoration(labelText: 'Scout Name'),
                onSaved: (String value) => matchData.scoutName = value,
              ),
              DropdownButtonFormField<String>(
                value: matchData.matchType,
                onChanged: (String value) {
                  setState(() {
                   matchData.matchType = value; 
                  });
                },
                decoration: InputDecoration(labelText: 'Match Type'),
                items: <DropdownMenuItem<String>>[
                  DropdownMenuItem<String>(
                    value: 'q',
                    child: Text('Qualification'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'qf',
                    child: Text('Quarterfinal'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'sf',
                    child: Text('Semifinal'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'f',
                    child: Text('Final'),
                  )
                ],
              ),
              NumberFormField(
                decoration: InputDecoration(labelText: 'Match Number'),
                onSaved: (int value) => matchData.matchNumber = value,
              ),
              NumberFormField(
                decoration: InputDecoration(labelText: 'Team Number'),
                onSaved: (int value) => matchData.teamNumber = value,
              ),
              DropdownButtonFormField<String>(
                value: matchData.allianceColor,
                onChanged: (String value) {
                  setState(() {
                    matchData.allianceColor = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Alliance Color'),
                items: <DropdownMenuItem<String>>[
                  DropdownMenuItem<String>(
                    value: 'r',
                    child: Text('Red'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'b',
                    child: Text('Blue'),
                  )
                ],
              ),
              // End game-agnostic form section
              DropdownButtonFormField(
                value: matchData.sandstormHabLevel,
                onChanged: (int value) {
                  setState(() {
                   matchData.sandstormHabLevel = value; 
                  });
                },
                decoration: InputDecoration(labelText: 'Starting HAB level'),
                items: <DropdownMenuItem<int>>[
                  DropdownMenuItem<int>(
                    value: 1,
                    child: Text('Level 1'),
                  ),
                  DropdownMenuItem<int>(
                    value: 2,
                    child: Text('Level 2'),
                  )
                ],
              ),
              CheckboxListTile(
                title: Text('Successfully left HAB platform'),
                value: matchData.sandstormHabSuccess,
                onChanged: (bool value) {
                  setState(() {
                    matchData.sandstormHabSuccess = value;
                  });
                },
              ),
              CounterFormField(
                title: 'Hatches during sandstorm'
                
              )
            ],
          ),
        ),
      )
    );
  }
}
