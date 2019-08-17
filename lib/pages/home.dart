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
            UserAccountsDrawerHeader(
              accountName: Text('Clayton Gilmer'),
              accountEmail: Text('netsecplanes@gmail.com'),
            ),
            ListTile(
              title: Text('Matches'),
              leading: Icon(Icons.calendar_today),
            ),
            ListTile(
              title: Text('Teams'),
              leading: Icon(Icons.people),
            ),
            ListTile(
              title: Text('First Pick'),
              leading: Icon(Icons.looks_one),
            ),
            ListTile(
              title: Text('Second Pick'),
              leading: Icon(Icons.looks_two),
            ),
            ListTile(
              title: Text('Settings'),
              leading: Icon(Icons.settings),
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
                  title: Text('Scout a match'),
                  subtitle: Text('Start scouting a new match.'),
                  leading: Icon(Icons.gamepad),
                )
              ],
            ),
          ),
          Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text('Scout a pit'),
                  subtitle: Text('Start scouting a team\'s pit.'),
                  leading: Icon(Icons.flag),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
