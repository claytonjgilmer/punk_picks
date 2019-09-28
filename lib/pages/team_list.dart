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
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: null,
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
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
                    title: Text(snapshot.data.documents[index].data['teamNumber']
                            .toString()),
                    subtitle: Text(
                      snapshot.data.documents[index].data['nickname']
                    ),
                    onTap: null
                  );
                },
              );
          }
        },
      ),
    );
  }
}
