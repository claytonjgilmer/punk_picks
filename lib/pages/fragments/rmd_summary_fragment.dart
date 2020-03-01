// 2020 SPECIFIC
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RmdSummaryPage extends StatefulWidget {
  final String teamNumber;
  final String matchType;
  final String matchNumber;
  RmdSummaryPage(this.teamNumber, this.matchType, this.matchNumber);
  _RmdSummaryPageState createState() => _RmdSummaryPageState();
}

class _RmdSummaryPageState extends State<RmdSummaryPage> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
          title: Text(this.widget.teamNumber +
              ' ' +
              this.widget.matchType.replaceAll('m', '').toUpperCase() +
              this.widget.matchNumber +
              ' Summary')),
      body: StreamBuilder(
        stream: Firestore.instance.collection('rmd').document(this.widget.teamNumber + this.widget.matchType + this.widget.matchNumber).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Center(child: CircularProgressIndicator());
            default:
              return new ListView(
                children: <Widget>[
                  ListTile(
                    title: Text('Scout Name:'),
                    trailing: Text(snapshot.data['scoutName']),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Match Type:'),
                    trailing: Text(snapshot.data['matchType'].toString().replaceAll('m', '').toUpperCase()),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Match Number:'),
                    trailing: Text(snapshot.data['matchNumber'].toString()),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Did they cross the auto line:'),
                    trailing: Text(snapshot.data['didCrossLineAuto'].toString()),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Cells scored on the low level during auto:'),
                    trailing: Text(snapshot.data['cellScoredL1Auto'].toString()),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Cells scored on the high level during auto:'),
                    trailing: Text(snapshot.data['cellScoredL2Auto'].toString()),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Cells scored on the high level in the circle during auto:'),
                    trailing: Text(snapshot.data['cellScoredL3Auto'].toString()),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Cells scored on the low level:'),
                    trailing: Text(snapshot.data['cellScoredL1'].toString()),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Cells scored on the high level:'),
                    trailing: Text(snapshot.data['cellScoredL2'].toString()),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Cells scored on the high level in the circle:'),
                    trailing: Text(snapshot.data['cellScoredL3'].toString()),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Did they successfully execute rotation control:'),
                    trailing: Text(snapshot.data['didRotationControl'].toString()),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Did they successfully execute position control:'),
                    trailing: Text(snapshot.data['didPositionControl'].toString()),
                  ),
                  ListTile(
                    title: Text('Did they play defense:'),
                    trailing: Text(snapshot.data['didPlayDefense'].toString()),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Did they park in the rendezvous zone:'),
                    trailing: Text(snapshot.data['didParkEndgame'].toString()),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Did they climb in the rendezvous zone:'),
                    trailing: Text(snapshot.data['didClimbEndgame'].toString()),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Did they successfully balance in the rendezvous zone:'),
                    trailing: Text(snapshot.data['didBalanceEndgame'].toString()),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Scout notes:'),
                    trailing: Text(snapshot.data['scoutNotes']),
                  )
                ],
              );
          }
        }
      )
    );
  }
}
