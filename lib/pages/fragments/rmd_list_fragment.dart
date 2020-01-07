import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:punk_picks/routes.dart';

class RmdList extends StatelessWidget {
  final String teamNumber;
  final String matchType;
  final String matchNumber;
  // from match summary
  RmdList(this.matchType, this.matchNumber, [this.teamNumber]);
  // from team summary
  RmdList.fromTeam(this.teamNumber, [this.matchType, this.matchNumber]);

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<QuerySnapshot>(
      stream: this.teamNumber == null  
      ? Firestore.instance
          .collection('rmd')
          .where('matchType', isEqualTo: this.matchType)
          .where('matchNumber', isEqualTo: int.parse(this.matchNumber))
          .orderBy('matchNumber')
          .snapshots()
      : Firestore.instance
          .collection('rmd')
          .where('teamNumber', isEqualTo: int.parse(this.teamNumber))
          .orderBy('matchNumber')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(
                  height: 24,
                ),
                Text('Come back later for scouting results.')
              ],
            );
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
                    leading: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          snapshot.data.documents[index].data['teamNumber']
                              .toString(),
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          snapshot.data.documents[index].data['matchType']
                                  .toString()
                                  .replaceAll('m', '')
                                  .toUpperCase() +
                              snapshot.data.documents[index].data['matchNumber']
                                  .toString(),
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    trailing: Text(snapshot
                        .data.documents[index].data['scoutName']
                        .toString()),
                    onTap: () {
                      int teamNumber =
                          snapshot.data.documents[index].data['teamNumber'];
                      String matchType =
                          snapshot.data.documents[index].data['matchType'];
                      int matchNumber =
                          snapshot.data.documents[index].data['matchNumber'];
                      router.navigateTo(context,
                          '/rmd_summary/$teamNumber/$matchType/$matchNumber',
                          transition: TransitionType.nativeModal);
                    });
              },
            );
        }
      },
    );
  }
}
