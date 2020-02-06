import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
      actions: <Widget>[
        DropdownButton(
            value: dropdownValue,
            style: TextStyle(
              color: Colors.white
            ),
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
              ]
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String val) {
              setState((){
                dropdownValue = val;
              });
            })
      ],
    ));
  }
}
