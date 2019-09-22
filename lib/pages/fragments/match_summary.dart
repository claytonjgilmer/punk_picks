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
  QuerySnapshot matchSnapshot;

  void initState() {
    super.initState();
    getMatchData();
  }

  void getMatchData() async {
    debugPrint('MATCH TYPE: ' + this.widget.matchType.toString());
    debugPrint('MATCH NUMBER: ' + this.widget.matchNumber.toString());
    matchSnapshot = await Firestore.instance
        .collection('matches')
        .getDocuments();
    debugPrint('MATCH DATA: ' + matchSnapshot.documents.toList().toString());
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(widget.matchType.toUpperCase() +
            widget.matchNumber +
            ' ' +
            'Summary'),
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
