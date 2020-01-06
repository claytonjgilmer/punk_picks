import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:punk_picks/routes.dart';

class MatchList extends StatelessWidget {
  MatchList([this.teamNumber]);
  final String teamNumber;

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<QuerySnapshot>(
      stream: this.teamNumber == '0'
          ? Firestore.instance
              .collection('matches')
              .orderBy('matchNumber')
              .snapshots()
          : Firestore.instance
              .collection('matches')
              .where('teamNumber', isEqualTo: int.parse(this.teamNumber))
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
                    title: Text(snapshot.data.documents[index].data['matchType']
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
                              color: Colors.blue, fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                    onTap: () {
                      String matchType =
                          snapshot.data.documents[index].data['matchType'];
                      int matchNumber =
                          snapshot.data.documents[index].data['matchNumber'];
                      router.navigateTo(
                          context, '/match_summary/$matchType/$matchNumber',
                          transition: TransitionType.nativeModal);
                    });
              },
            );
        }
      },
    );
  }
}
