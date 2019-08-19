import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:punk_picks/models/model_2019.dart';

class MatchScoutPage extends StatefulWidget {
  _MatchScoutPageState createState() => _MatchScoutPageState();
}

class _MatchScoutPageState extends State<MatchScoutPage> {
  Model2019 scoutData;

  void initState() {
    super.initState();
    scoutData = Model2019(
      maxRocketPlacementHeight: 3 
    );
  }

  void testFirestore() async {
    print(scoutData.maxRocketPlacementHeight);
    Firestore.instance.collection('matches').document('q1').updateData({'maxRocketPlacementHeight': scoutData.maxRocketPlacementHeight});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Match Scout Form')
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            child: Text('Firestore Test'),
            onPressed: testFirestore,
          )
        ],
      ),
    );
  }
}
