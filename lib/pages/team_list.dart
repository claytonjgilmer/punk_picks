import 'package:flutter/material.dart';

class TeamListPage extends StatefulWidget {
  _TeamListPageState createState() => _TeamListPageState();
}

class _TeamListPageState extends State<TeamListPage> {

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teams'),
      ),
    );
  }
}