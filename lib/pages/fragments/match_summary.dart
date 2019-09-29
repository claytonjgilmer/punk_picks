// 2019 SPECIFIC
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MatchSummaryPage extends StatefulWidget {
  final String matchType;
  final String matchNumber;
  MatchSummaryPage(
    this.matchType,
    this.matchNumber,
  );
  _MatchSummaryPageState createState() => _MatchSummaryPageState();
}

class _MatchSummaryPageState extends State<MatchSummaryPage> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text(this.widget.matchType.toUpperCase().replaceAll('M', '') +
              this.widget.matchNumber.toString() +
              ' ' +
              'Summary'),
        ),
        body: StreamBuilder(
            stream: Firestore.instance
                .collection('matches')
                .document(this.widget.matchType + this.widget.matchNumber)
                .snapshots(),
            builder: (BuildContext context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return new Center(child: CircularProgressIndicator(),);
                default:
                  return new ListView(
                    children: <Widget>[
                      Center(child: Text(
                        this.widget.matchType.toUpperCase().replaceAll('M', '') +
                        this.widget.matchNumber.toString(),
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.w600
                        ),
                      )),
                    ],
                  );
              }
            },
        )
      );
  }
}
