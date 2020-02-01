import 'package:flutter/material.dart';
import 'package:punk_picks/pages/fragments/team_list_fragment.dart';

class TeamListPage extends StatefulWidget {
  _TeamListPageState createState() => _TeamListPageState();
}

class _TeamListPageState extends State<TeamListPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Teams'),
      ),
      body: TeamList()
    );
  }
}
