import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:punk_picks/routes.dart';

class TeamList extends StatelessWidget {
  final String sortBy;
  final bool descending;
  TeamList(this.sortBy, this.descending);

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('teams')
          .orderBy(sortBy, descending: descending)
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
                    trailing: (this.sortBy == "teamNumber")
                        ? null
                        : Text(
                            this.sortBy +
                                ": " +
                                snapshot.data.documents[index].data[this.sortBy]
                                    .toString(),
                            style: TextStyle(fontWeight: FontWeight.w300),
                          ),
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
