import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Matches'),
            ),
            ListTile(
              title: Text('Teams'),
            ),
            ListTile(
              title: Text('Pick List'),
            )
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text('Scout a new match'),
                  subtitle: Text('Scout a new match'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
