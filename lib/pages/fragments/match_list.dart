import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:punk_picks/routes.dart';

class MatchListPage extends StatefulWidget {
  final String teamNumber;
  MatchListPage([this.teamNumber = '0']);
  _MatchListPageState createState() => _MatchListPageState();
}

class _MatchListPageState extends State<MatchListPage> {
  void initState() {
    super.initState();
  }

  void navigateToMatchPage(String matchType, int matchNumber) {
    router.navigateTo(context, '/match_summary/$matchType/$matchNumber',
        transition: TransitionType.nativeModal);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Matches'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: null,
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: this.widget.teamNumber == '0'
            ? Firestore.instance
                .collection('matches')
                .orderBy('matchNumber')
                .snapshots()
            : Firestore.instance
                .collection('matches')
                .where('teamNumber',
                    isEqualTo: int.parse(this.widget.teamNumber))
                .orderBy('matchNumber')
                .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Center(child: CircularProgressIndicator());
            default:
              return new ListView.separated(
                itemCount: snapshot.data.documents.length,
                separatorBuilder: (context, index) {
                  return new Divider(
                    height: 1.0,
                  );
                },
                itemBuilder: (context, index) {
                  return new ListTile(
                      title: Text(snapshot
                              .data.documents[index].data['matchType']
                              .toString()
                              .replaceAll('m', '')
                              .toUpperCase() +
                          snapshot.data.documents[index].data['matchNumber']
                              .toString()),
                      trailing: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            snapshot.data.documents[index].data['redAlliance']
                                .toString()
                                .replaceAll('[', '')
                                .replaceAll(']', '')
                                .replaceAll(',', ''),
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.w300),
                          ),
                          Text(
                            snapshot.data.documents[index].data['blueAlliance']
                                .toString()
                                .replaceAll('[', '')
                                .replaceAll(']', '')
                                .replaceAll(',', ''),
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w300),
                          )
                        ],
                      ),
                      onTap: () {
                        navigateToMatchPage(
                            snapshot.data.documents[index].data['matchType'],
                            snapshot.data.documents[index].data['matchNumber']);
                      });
                },
              );
          }
        },
      ),
    );
  }
}
