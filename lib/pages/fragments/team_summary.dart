// 2019 SPECIFIC
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:punk_picks/routes.dart';

class TeamSummaryPage extends StatefulWidget {
  final String teamNumber;
  TeamSummaryPage(
    this.teamNumber,
  );
  _TeamSummaryPageState createState() => _TeamSummaryPageState();
}

class _TeamSummaryPageState extends State<TeamSummaryPage> {
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(this.widget.teamNumber + ' Summary'),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('teams').document(this.widget.teamNumber).snapshots(),
        builder: (BuildContext context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Center(
                child: CircularProgressIndicator(),
              );
            default:
              return new ListView(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 12,
                            ),
                            Text(
                              this.widget.teamNumber,
                              style: TextStyle(
                                fontSize: 60,
                                fontWeight: FontWeight.w600
                              )
                            ),
                            Spacer(),
                            Image.asset(
                              'assets/diamond.png',
                              height: 100,
                              width: 100
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 12,
                            ),
                            Text(
                              snapshot.data['nickname'],
                              style: TextStyle(
                              fontSize: 20
                              ),
                            ),
                          ],
                        ),   
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 12,
                            ),
                            Text(
                              'Rank: ' + snapshot.data['currRank'].toString(),
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Spacer(),
                            Text(
                              'Rookie Year: ' + snapshot.data['rookieYear'].toString(),
                              style: TextStyle(
                                fontSize: 18
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            )
                          ],
                        )
                      ],
                    )
                  ),
                  SizedBox(height: 12),
                  Divider(),
                  ListTile(
                    title: Text('Matches'),
                    trailing: Icon(Icons.arrow_right),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Submitted Scouting Results'),
                    trailing: Icon(Icons.arrow_right),
                  ),
                  Divider(),
                ],
              );
          }
        },
      ),
    );

  }
}