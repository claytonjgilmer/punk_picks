import 'package:flutter/material.dart';
import 'package:punk_picks/pages/fragments/team_list_fragment.dart';

class FirstPickPage extends StatefulWidget {
  _FirstPickPageState createState() => _FirstPickPageState();
}

class _FirstPickPageState extends State<FirstPickPage> {

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Pick List'),
      ),
      body: TeamList('firstPickability', true),
    );
  }
}