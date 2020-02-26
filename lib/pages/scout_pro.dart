import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:punk_picks/routes.dart';
import 'package:punk_picks/pages/fragments/team_list_fragment.dart';

class ScoutProPage extends StatefulWidget {
  _ScoutProPageState createState() => _ScoutProPageState();
}

class _ScoutProPageState extends State<ScoutProPage> {
  String dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = 'avgDidCrossLineAuto';
  }

  void navigateToBarGraph() {
    router.navigateTo(context, '/bar_graph/$dropdownValue',
        transition: TransitionType.nativeModal);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          DropdownButton(
              value: dropdownValue,
              style: TextStyle(color: Colors.white),
              items: <String>[
                'avgDidCrossLineAuto',
                'avgCellScoredL1Auto',
                'avgCellScoredL2Auto',
                'avgCellScoredL3Auto',
                'avgCellScoredL1',
                'avgCellScoredL2',
                'avgCellScoredL3',
                'avgDidRotationControl',
                'avgDidPositionControl',
                'avgDidParkEndgame',
                'avgDidClimbEndgame',
                'avgDidBalanceEndgame',
                'stdDidCrossLineAuto',
                'stdCellScoredL1Auto',
                'stdCellScoredL2Auto',
                'stdCellScoredL3Auto',
                'stdCellScoredL1',
                'stdCellScoredL2',
                'stdCellScoredL3',
                'stdDidRotationControl',
                'stdDidPositionControl',
                'stdDidParkEndgame',
                'stdDidClimbEndgame',
                'stdDidBalanceEndgame'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(color: Colors.black),
                  ),
                );
              }).toList(),
              onChanged: (String val) {
                setState(() {
                  dropdownValue = val;
                });
              }),
          IconButton(
              icon: Icon(Icons.insert_chart), onPressed: navigateToBarGraph),
        ],
      ),
      body: TeamList(dropdownValue, true),
    );
  }
}
