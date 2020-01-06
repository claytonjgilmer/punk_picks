import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:punk_picks/routes.dart';

class TeamList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('teams')
          .orderBy('teamNumber')
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
                        .data.documents[index].data['teamNumber']
                        .toString()),
                    subtitle:
                        Text(snapshot.data.documents[index].data['nickname']),
                    onTap: () {
                      int teamNumber =
                          snapshot.data.documents[index].data['teamNumber'];
                      router.navigateTo(context, '/team_summary/$teamNumber',
                          transition: TransitionType.nativeModal);
                    });
              },
            );
        }
      },
    );
  }
}
