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
      setState((){});
    });
  }

  void favoriteTeam() async {
    prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList('favorites');
    favorites.add(this.widget.teamNumber);
    prefs.setStringList('favorites', favorites);
    isFavorite = true;
    debugPrint('FAVORITES: ' + prefs.getStringList('favorites').toString());
    setState((){});
  }

  void unfavoriteTeam() async {
    prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList('favorites');
    favorites.remove(this.widget.teamNumber);
    prefs.setStringList('favorites', favorites);
    isFavorite = false;
    debugPrint('FAVORITES: ' + prefs.getStringList('favorites').toString());
    setState((){});
  }


  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text(this.widget.teamNumber + ' Summary'),
          actions: <Widget>[
            IconButton(
              icon: isFavorite == true ? Icon(Icons.check) : Icon(Icons.star),
              onPressed: isFavorite == true
              ? unfavoriteTeam
              : favoriteTeam
            )
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
                                    Spacer(),
                                    Image.asset('assets/diamond.png',
                                        height: 100, width: 100)
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
                                    Text(
                                      snapshot.data['currRank'].toString(),
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )),
                      ],
                    );
                }
              },
            ),
            MatchList(
              this.widget.teamNumber
            ),
            RmdList.fromTeam(this.widget.teamNumber),
            PitSummary(this.widget.teamNumber)
          ],
        ));
  }
}
