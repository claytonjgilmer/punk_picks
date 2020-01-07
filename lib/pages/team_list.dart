import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:punk_picks/routes.dart';
import 'package:punk_picks/pages/fragments/team_list_fragment.dart';

class TeamListPage extends StatefulWidget {
  _TeamListPageState createState() => _TeamListPageState();
}

class _TeamListPageState extends State<TeamListPage> {

  void initState() {
    super.initState();
  }

  void navigateToTeamSummary(int teamNumber) {
    router.navigateTo(context, '/team_summary/$teamNumber', transition: TransitionType.nativeModal);
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
