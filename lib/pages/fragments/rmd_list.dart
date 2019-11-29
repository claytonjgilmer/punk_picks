import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:punk_picks/routes.dart';

class RmdListPage extends StatefulWidget {
  final String matchType;
  final String matchNumber;
  RmdListPage(
    this.matchType,
    this.matchNumber
  );
  _RmdListPageState createState() => _RmdListPageState();
}

class _RmdListPageState extends State<RmdListPage> {
  void initState() {
    super.initState();
  }

  void navigateToRmdPage(int teamNumber, String matchType, int matchNumber) {
    router.navigateTo(context, '/rmd_summary/$teamNumber/$matchType/$matchNumber',
        transition: TransitionType.nativeModal);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(this.widget.matchType.replaceAll('m', '').toUpperCase() + this.widget.matchNumber + ' Scouting Submissions'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: null,
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('rmd')
            .where('matchType', isEqualTo: this.widget.matchType)
            .where('matchNumber', isEqualTo: int.parse(this.widget.matchNumber))
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
                      title: Text(
                        snapshot.data.documents[index].data['teamNumber'].toString(),
                      ),
                      onTap: () {
                        navigateToRmdPage(
                            snapshot.data.documents[index].data['teamNumber'],
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
