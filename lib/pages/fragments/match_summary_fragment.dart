// 2020 SPECIFIC
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:punk_picks/routes.dart';
import 'package:punk_picks/pages/fragments/rmd_list_fragment.dart';

class MatchSummaryPage extends StatefulWidget {
  final String matchType;
  final String matchNumber;
  MatchSummaryPage(
    this.matchType,
    this.matchNumber,
  );
  _MatchSummaryPageState createState() => _MatchSummaryPageState();
}

class _MatchSummaryPageState extends State<MatchSummaryPage>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 2);
  }

  void navigateToTeamSummary(int teamNumber) {
    router.navigateTo(context, '/team_summary/$teamNumber', transition: TransitionType.nativeModal);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text(this.widget.matchType.toUpperCase().replaceAll('M', '') +
              this.widget.matchNumber.toString() +
              ' ' +
              'Summary'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.info),
                text: 'INFO',
              ),
              Tab(
                icon: Icon(Icons.mail),
                text: 'RESULTS',
              )
            ],
            controller: tabController,
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: <Widget>[
            StreamBuilder(
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
                        SizedBox(
                          height: 24,
                        ),
                        Center(
                            child: Text(
                          this
                                  .widget
                                  .matchType
                                  .toUpperCase()
                                  .replaceAll('M', '') +
                              this.widget.matchNumber.toString(),
                          style: TextStyle(
                              fontSize: 60, fontWeight: FontWeight.w600),
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
                        if (snapshot.data['redAllianceScore'] == null &&
                            snapshot.data['blueAllianceScore'] == null)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                '??',
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
                                  '??',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                        SizedBox(
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                InkWell(
                                  child: Text(
                                    snapshot.data['redAlliance'][0].toString(),
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  onTap: () {
                                    navigateToTeamSummary(snapshot.data['redAlliance'][0]);
                                  },
                                ),
                                Divider(
                                  height: 8,
                                ),
                                InkWell(
                                  child: Text(
                                    snapshot.data['redAlliance'][1].toString(),
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  onTap: () {
                                    navigateToTeamSummary(snapshot.data['redAlliance'][1]);
                                  },
                                ),
                                Divider(
                                  height: 8,
                                ),
                                InkWell(
                                  child: Text(
                                    snapshot.data['redAlliance'][2].toString(),
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  onTap: () {
                                    navigateToTeamSummary(snapshot.data['redAlliance'][2]);
                                  },
                                ),
                                Row(
                                  children: <Widget>[
                                    if (snapshot.data['redWheelRP'] == true)
                                      Icon(Icons.power_settings_new),
                                    if (snapshot.data['redClimbRP'] == true)
                                      Icon(Icons.arrow_upward),
                                    if (snapshot.data['redWheelRP'] == false &&
                                        snapshot.data['redClimbRP'] == false)
                                      SizedBox(
                                        height: 24.0,
                                        width: 24.0,
                                      )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              width: 100,
                            ),
                            Column(
                              children: <Widget>[
                                InkWell(
                                  child: Text(
                                    snapshot.data['blueAlliance'][0].toString(),
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  onTap: () {
                                    navigateToTeamSummary(snapshot.data['blueAlliance'][0]);
                                  },
                                ),
                                Divider(
                                  height: 8,
                                ),
                                InkWell(
                                  child: Text(
                                    snapshot.data['blueAlliance'][1].toString(),
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  onTap: () {
                                    navigateToTeamSummary(snapshot.data['blueAlliance'][1]);
                                  },
                                ),
                                Divider(
                                  height: 8,
                                ),
                                InkWell(
                                  child: Text(
                                    snapshot.data['blueAlliance'][2].toString(),
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  onTap: () {
                                    navigateToTeamSummary(snapshot.data['blueAlliance'][2]);
                                  },
                                ),
                                Row(
                                  children: <Widget>[
                                    if (snapshot.data['blueWheelRP'] == true)
                                      Icon(Icons.power_settings_new),
                                    if (snapshot.data['blueClimbRP'] == true)
                                      Icon(Icons.arrow_upward),
                                    if (snapshot.data['blueWheelRP'] ==
                                            false &&
                                        snapshot.data['blueClimbRP'] == false)
                                      SizedBox(
                                        height: 24.0,
                                        width: 24.0,
                                      )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Divider(),
                      ],
                      
                    );
                }
              },
            ),
            RmdList(this.widget.matchType, this.widget.matchNumber)
          ],
        ));
  }
}
