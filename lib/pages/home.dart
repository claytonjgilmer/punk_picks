import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluro/fluro.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:punk_picks/routes.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String displayName = '';
  String email = '';
  String photoUrl = '';

  void initState() {
    super.initState();
    updateGlobalInfo();
    updateUserInfo();
  }

  void updateGlobalInfo() async {
    DocumentSnapshot snapshot = await Firestore.instance.collection('global').document('client').get();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String currYear = snapshot.data['currYear'].toString();
    String currComp = snapshot.data['currComp'].toString();
    prefs.setString('currYear', currYear);
    prefs.setString('currComp', currComp);
  }

  void updateUserInfo() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('displayName', user.displayName);
    prefs.setString('email', user.email);
    prefs.setString('photoUrl', user.photoUrl);
    displayName = prefs.getString('displayName');
    email = prefs.getString('email');
    photoUrl = prefs.getString('photoUrl');
    setState((){});
  }

  void signOut() {
    final googleSignIn = GoogleSignIn();
    FirebaseAuth.instance.signOut();
    googleSignIn.signOut();
    router.navigateTo(context, '/login', transition: TransitionType.fadeIn, clearStack: true);
  }

  void navigateToMatchScout() {
    router.navigateTo(context, '/match_scout', transition: TransitionType.fadeIn);
  }

  void navigateToPitScout() {
    router.navigateTo(context, '/pit_scout', transition: TransitionType.fadeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(displayName),
              accountEmail: Text(email),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(photoUrl),
              ),
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
            ),
            ListTile(
              title: Text('Sign Out'),
              onTap: signOut,
            )
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          InkWell(
            onTap: navigateToMatchScout,
            child: Card(
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
          ),
         InkWell(
           onTap: navigateToPitScout,
           child: Card(
             child: Column(
               children: <Widget>[
                 ListTile(
                   title: Text('Scout a pit'),
                   subtitle: Text('Start scouting a team\'s pit.'),
                   leading: Icon(Icons.flag),
                 )
               ],
             ),
           ),
          )
        ],
      ),
    );
  }
}
