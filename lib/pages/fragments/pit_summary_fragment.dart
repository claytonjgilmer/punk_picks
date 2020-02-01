// 2020 SPECIFIC
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PitSummary extends StatelessWidget {
  final String teamNumber;
  PitSummary(
    this.teamNumber,
  );

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: Firestore.instance
          .collection('rpd')
          .document(this.teamNumber + 'pd')
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.flag,
                  size: 48,
                ),
                SizedBox(
                  height: 24,
                ),
                Text('Come back later for pit info.')
              ],
            );
          default:
            if (snapshot.data.exists) {
              return new ListView(
                children: <Widget>[
                  ListTile(
                    title: Text('Scout name:'),
                    trailing: Text(snapshot.data['scoutName']),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Drive train:'),
                    trailing: Text(snapshot.data['driveTrain']),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Drive motors:'),
                    trailing: Text(snapshot.data['motor']),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Programming language:'),
                    trailing: Text(snapshot.data['progLang']),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Do they have vision:'),
                    trailing: Text(snapshot.data['hasVision'].toString()),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Can they do rotational control:'),
                    trailing:
                        Text(snapshot.data['canDoRotationControl'].toString()),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Can they do position control:'),
                    trailing:
                        Text(snapshot.data['canDoPositionControl'].toString()),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Can they drive under the trench:'),
                    trailing:
                        Text(snapshot.data['canDoPositionControl'].toString()),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Vibe check:'),
                    trailing: Text(snapshot.data['teamVibe'].toString()),
                  ),
                  Divider(),
                  CachedNetworkImage(
                    imageUrl: snapshot.data['imageUrl'],
                    placeholder: (BuildContext context, String foo) {
                      return CircularProgressIndicator();
                    },
                    height: 480,
                    width: 480,
                  )
                ],
              );
            }
            // needed if user goes to pit summary when no pit data has been submitted yet
            else {
              return new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.flag,
                    size: 48
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Text('Come back later for pit info.')
                ],
              );
            }
        }
      },
    );
  }
}
