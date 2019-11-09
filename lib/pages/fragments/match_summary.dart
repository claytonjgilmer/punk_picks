// 2019 SPECIFIC
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MatchSummaryPage extends StatefulWidget {
  final String matchType;
  final String matchNumber;
  MatchSummaryPage(
    this.matchType,
    this.matchNumber,
  );
  _MatchSummaryPageState createState() => _MatchSummaryPageState();
}

class _MatchSummaryPageState extends State<MatchSummaryPage> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text(this.widget.matchType.toUpperCase().replaceAll('M', '') +
              this.widget.matchNumber.toString() +
              ' ' +
              'Summary'),
        ),
        body: StreamBuilder(
          stream: Firestore.instance
              .collection('matches')
              .document(this.widget.matchType + this.widget.matchNumber)
              .snapshots(),
          builder: (BuildContext context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return new Center(
                  child: CircularProgressIndicator(),
                );
              default:
                return new ListView(
                  children: <Widget>[
                    Center(
                        child: Text(
                      this.widget.matchType.toUpperCase().replaceAll('M', '') +
                          this.widget.matchNumber.toString(),
                      style:
                          TextStyle(fontSize: 60, fontWeight: FontWeight.w600),
                    )),
                    SizedBox(
                      height: 20,
                    ),
                    if (snapshot.data['redAllianceScore'] != null &&
                        snapshot.data['blueAllianceScore'] != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            snapshot.data['redAllianceScore'].toString(),
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 30,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            ' vs. ',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            snapshot.data['blueAllianceScore'].toString(),
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 30,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              snapshot.data["redAlliance"][0].toString(),
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 25,
                                fontWeight: FontWeight.w400
                              ),
                            ),
                            Text(
                              snapshot.data["redAlliance"][1].toString(),
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 25,
                                fontWeight: FontWeight.w400
                              ),
                            ),
                            Text(
                              snapshot.data["redAlliance"][2].toString(),
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 25,
                                fontWeight: FontWeight.w400
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 150,
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              snapshot.data["blueAlliance"][0].toString(),
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 25,
                                fontWeight: FontWeight.w400
                              ),
                            ),
                            Text(
                              snapshot.data["blueAlliance"][1].toString(),
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 25,
                                fontWeight: FontWeight.w400
                              ),
                            ),
                            Text(
                              snapshot.data["blueAlliance"][2].toString(),
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 25,
                                fontWeight: FontWeight.w400
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(),
                  ],
                );
            }
          },
        ));
  }
}
