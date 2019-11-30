// 2019 SPECIFIC
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:punk_picks/routes.dart';

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

  void navigateToRmdList(String matchType, String matchNumber) {
    router.navigateTo(context, '/rmd_list/$matchType/$matchNumber',
        transition: TransitionType.nativeModal);
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
                          if (snapshot.data['redAllianceScore'] >
                                  snapshot.data['blueAllianceScore'] ||
                              snapshot.data['redAllianceScore'] ==
                                  snapshot.data['blueAllianceScore'])
                            Icon(Icons.check),
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
                          ),
                          if (snapshot.data['redAllianceScore'] <
                                  snapshot.data['blueAllianceScore'] ||
                              snapshot.data['redAllianceScore'] ==
                                  snapshot.data['blueAllianceScore'])
                            Icon(Icons.check)
                        ],
                      ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                              Text(
                                snapshot.data['redAlliance'][0].toString(),
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                snapshot.data['redAlliance'][1].toString(),
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                snapshot.data['redAlliance'][2].toString(),
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w400),
                              ),
                              Row(
                                children: <Widget>[
                                  if (snapshot.data['redRocketRP'] == true)
                                    Icon(Icons.airplanemode_active),
                                  if (snapshot.data['redHabRP'] == true)
                                    Icon(Icons.arrow_upward),
                                  if (snapshot.data['redRocketRP'] == false && snapshot.data['redHabRP'] == false)
                                    SizedBox(height: 24.0, width: 24.0,)
                                ],
                              )
                          ],
                        ),
                        SizedBox(
                          width: 100,
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              snapshot.data["blueAlliance"][0].toString(),
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              snapshot.data["blueAlliance"][1].toString(),
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              snapshot.data["blueAlliance"][2].toString(),
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w400),
                            ),
                            Row(
                                children: <Widget>[
                                  if (snapshot.data['blueRocketRP'] == true)
                                    Icon(Icons.airplanemode_active),
                                  if (snapshot.data['blueHabRP'] == true)
                                    Icon(Icons.arrow_upward),
                                  if (snapshot.data['redRocketRP'] == false && snapshot.data['redHabRP'] == false)
                                    SizedBox(height: 24.0, width: 24.0,)
                                ],
                              )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(),
                    ListTile(
                        title: Text('Submitted Scouting Results'),
                        trailing: Icon(Icons.arrow_right),
                        onTap: () {
                          navigateToRmdList(
                              this.widget.matchType, this.widget.matchNumber);
                        }),
                    Divider()
                  ],
                );
            }
          },
        ));
  }
}
