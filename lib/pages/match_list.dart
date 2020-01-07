import 'package:flutter/material.dart';
import 'package:punk_picks/pages/fragments/match_list_fragment.dart';

class MatchListPage extends StatefulWidget {
  _MatchListPageState createState() => _MatchListPageState();
}

class _MatchListPageState extends State<MatchListPage> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Matches'),
      ),
      body: MatchList('0'),
    );
  }
}
