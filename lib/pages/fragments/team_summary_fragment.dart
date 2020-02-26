// 2020 SPECIFIC
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:punk_picks/pages/fragments/match_list_fragment.dart';
import 'package:punk_picks/pages/fragments/pit_summary_fragment.dart';
import 'package:punk_picks/pages/fragments/rmd_list_fragment.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeamSummaryPage extends StatefulWidget {
  final String teamNumber;
  TeamSummaryPage(
    this.teamNumber,
  );
  _TeamSummaryPageState createState() => _TeamSummaryPageState();
}

class _TeamSummaryPageState extends State<TeamSummaryPage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  SharedPreferences prefs;
  bool isFavorite;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 4);
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getStringList('favorites').contains(this.widget.teamNumber))
        isFavorite = true;
      else
        isFavorite = false;
      setState(() {});
    });
  }

  void favoriteTeam() async {
    prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList('favorites');
    favorites.add(this.widget.teamNumber);
    prefs.setStringList('favorites', favorites);
    isFavorite = true;
    debugPrint('FAVORITES: ' + prefs.getStringList('favorites').toString());
    setState(() {});
  }

  void unfavoriteTeam() async {
    prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList('favorites');
    favorites.remove(this.widget.teamNumber);
    prefs.setStringList('favorites', favorites);
    isFavorite = false;
    debugPrint('FAVORITES: ' + prefs.getStringList('favorites').toString());
    setState(() {});
  }

  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text(this.widget.teamNumber + ' Summary'),
          actions: <Widget>[
            IconButton(
                icon: isFavorite == true ? Icon(Icons.check) : Icon(Icons.star),
                onPressed: isFavorite == true ? unfavoriteTeam : favoriteTeam)
          ],
          bottom: TabBar(
            controller: tabController,
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.info),
                text: 'INFO',
              ),
              Tab(
                icon: Icon(Icons.calendar_today),
                text: 'MATCHES',
              ),
              Tab(
                icon: Icon(Icons.mail),
                text: 'RESULTS',
              ),
              Tab(
                icon: Icon(Icons.flag),
                text: 'PIT',
              )
            ],
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: <Widget>[
            StreamBuilder(
              stream: Firestore.instance
                  .collection('teams')
                  .document(this.widget.teamNumber)
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
                                    Text(this.widget.teamNumber,
                                        style: TextStyle(
                                            fontSize: 60,
                                            fontWeight: FontWeight.w600)),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Text(
                                      snapshot.data['nickname'],
                                      style: TextStyle(fontSize: 20),
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
                                    Icon(Icons.format_list_numbered),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      snapshot.data['currRank'].toString(),
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(),
                                Center(
                                    child: Text(
                                  'Averages',
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold),
                                )),
                                ListTile(
                                  title: Text('Did they cross the auto line:'),
                                  trailing: Text(snapshot
                                      .data['avgDidCrossLineAuto']
                                      .toString()),
                                ),
                                Divider(),
                                ListTile(
                                  title: Text(
                                      'Cells scored on the low level during auto:'),
                                  trailing: Text(snapshot
                                      .data['avgCellScoredL1Auto']
                                      .toString()),
                                ),
                                Divider(),
                                ListTile(
                                  title: Text(
                                      'Cells scored on the high level during auto:'),
                                  trailing: Text(snapshot
                                      .data['avgCellScoredL2Auto']
                                      .toString()),
                                ),
                                Divider(),
                                ListTile(
                                  title: Text(
                                      'Cells scored on the high level in the circle during auto:'),
                                  trailing: Text(snapshot
                                      .data['avgCellScoredL3Auto']
                                      .toString()),
                                ),
                                Divider(),
                                ListTile(
                                  title: Text('Cells scored on the low level:'),
                                  trailing: Text(snapshot
                                      .data['avgCellScoredL1']
                                      .toString()),
                                ),
                                Divider(),
                                ListTile(
                                  title:
                                      Text('Cells scored on the high level:'),
                                  trailing: Text(snapshot
                                      .data['avgCellScoredL2']
                                      .toString()),
                                ),
                                Divider(),
                                ListTile(
                                  title: Text(
                                      'Cells scored on the high level in the circle:'),
                                  trailing: Text(snapshot
                                      .data['avgCellScoredL3']
                                      .toString()),
                                ),
                                Divider(),
                                ListTile(
                                  title: Text(
                                      'Did they successfully execute rotation control:'),
                                  trailing: Text(snapshot
                                      .data['avgDidRotationControl']
                                      .toString()),
                                ),
                                Divider(),
                                ListTile(
                                  title: Text(
                                      'Did they successfully execute position control:'),
                                  trailing: Text(snapshot
                                      .data['avgDidPositionControl']
                                      .toString()),
                                ),
                                Divider(),
                                ListTile(
                                  title: Text(
                                      'Did they park in the rendezvous zone:'),
                                  trailing: Text(snapshot
                                      .data['avgDidParkEndgame']
                                      .toString()),
                                ),
                                Divider(),
                                ListTile(
                                  title: Text(
                                      'Did they climb in the rendezvous zone:'),
                                  trailing: Text(snapshot
                                      .data['avgDidClimbEndgame']
                                      .toString()),
                                ),
                                Divider(),
                                ListTile(
                                  title: Text(
                                      'Did they successfully balance in the rendezvous zone:'),
                                  trailing: Text(snapshot
                                      .data['avgDidBalanceEndgame']
                                      .toString()),
                                ),
                                Center(
                                    child: Text(
                                  'Standard Deviations',
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold),
                                )),
                                ListTile(
                                  title: Text('Did they cross the auto line:'),
                                  trailing: Text(snapshot
                                      .data['stdDidCrossLineAuto']
                                      .toString()),
                                ),
                                Divider(),
                                ListTile(
                                  title: Text(
                                      'Cells scored on the low level during auto:'),
                                  trailing: Text(snapshot
                                      .data['stdCellScoredL1Auto']
                                      .toString()),
                                ),
                                Divider(),
                                ListTile(
                                  title: Text(
                                      'Cells scored on the high level during auto:'),
                                  trailing: Text(snapshot
                                      .data['stdCellScoredL2Auto']
                                      .toString()),
                                ),
                                Divider(),
                                ListTile(
                                  title: Text(
                                      'Cells scored on the high level in the circle during auto:'),
                                  trailing: Text(snapshot
                                      .data['stdCellScoredL3Auto']
                                      .toString()),
                                ),
                                Divider(),
                                ListTile(
                                  title: Text('Cells scored on the low level:'),
                                  trailing: Text(snapshot
                                      .data['stdCellScoredL1']
                                      .toString()),
                                ),
                                Divider(),
                                ListTile(
                                  title:
                                      Text('Cells scored on the high level:'),
                                  trailing: Text(snapshot
                                      .data['stdCellScoredL2']
                                      .toString()),
                                ),
                                Divider(),
                                ListTile(
                                  title: Text(
                                      'Cells scored on the high level in the circle:'),
                                  trailing: Text(snapshot
                                      .data['stdCellScoredL3']
                                      .toString()),
                                ),
                                Divider(),
                                ListTile(
                                  title: Text(
                                      'Did they successfully execute rotation control:'),
                                  trailing: Text(snapshot
                                      .data['stdDidRotationControl']
                                      .toString()),
                                ),
                                Divider(),
                                ListTile(
                                  title: Text(
                                      'Did they successfully execute position control:'),
                                  trailing: Text(snapshot
                                      .data['stdDidPositionControl']
                                      .toString()),
                                ),
                                Divider(),
                                ListTile(
                                  title: Text(
                                      'Did they park in the rendezvous zone:'),
                                  trailing: Text(snapshot
                                      .data['stdDidParkEndgame']
                                      .toString()),
                                ),
                                Divider(),
                                ListTile(
                                  title: Text(
                                      'Did they climb in the rendezvous zone:'),
                                  trailing: Text(snapshot
                                      .data['stdDidClimbEndgame']
                                      .toString()),
                                ),
                                Divider(),
                                ListTile(
                                  title: Text(
                                      'Did they successfully balance in the rendezvous zone:'),
                                  trailing: Text(snapshot
                                      .data['stdDidBalanceEndgame']
                                      .toString()),
                                ),
                              ],
                            )),
                      ],
                    );
                }
              },
            ),
            MatchList(this.widget.teamNumber),
            RmdList.fromTeam(this.widget.teamNumber),
            PitSummary(this.widget.teamNumber)
          ],
        ));
  }
}
