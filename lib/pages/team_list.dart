import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TeamListPage extends StatefulWidget {
  _TeamListPageState createState() => _TeamListPageState();
}

class _TeamListPageState extends State<TeamListPage> {

  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Teams'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('teams').orderBy('teamNumber').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Center(child: CircularProgressIndicator());
            default: 
              return new ListView(
                physics: ScrollPhysics(),
                children: snapshot.data.documents.map((DocumentSnapshot document){ 
                  return new Column(
                    children: <Widget>[
                      Divider(
                        height: 10,
                      ),
                      ListTile(
                        title: Text(document['teamNumber'].toString()),
                        subtitle: Text(document['teamName']),
                      ),
                    ],
                  );
                }).toList(),
              );
          }
        },
      ),
    );
  }
}