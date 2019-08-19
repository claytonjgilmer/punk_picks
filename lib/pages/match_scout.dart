import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:punk_picks/models/model_2019.dart';
import 'package:punk_picks/models/model_match.dart';
import 'package:punk_picks/components/counter_form_field.dart';
import 'package:punk_picks/components/number_form_field.dart';

class MatchScoutPage extends StatefulWidget {
  _MatchScoutPageState createState() => _MatchScoutPageState();
}

class _MatchScoutPageState extends State<MatchScoutPage> {
  final formKey = GlobalKey<FormState>();
  ModelMatch matchData;
  Model2019 gameData;

  void initState() {
    super.initState();
    matchData = ModelMatch(
      scoutName: '',
      matchNumber: 1,
      allianceColor: 'r',
      scoutNotes: '',
    );
    gameData = Model2019(
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
              TextFormField(
                decoration: InputDecoration(labelText: 'Scout Name'),
                onSaved: (String value) {
                  setState(() {
                    matchData.scoutName = value;
                  });
                },
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

            ],
          ),
        ),
      )
    );
  }
}
