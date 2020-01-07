import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluro/fluro.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:punk_picks/routes.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String displayName = '';
  String email = '';
  String photoUrl = '';
  bool compReady;

  void initState() {
    super.initState();
    updateUserInfo();
  }

  void updateUserInfo() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot globals =
        await Firestore.instance.collection('global').document('client').get();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('displayName', user.displayName);
    prefs.setString('email', user.email);
    prefs.setString('photoUrl', user.photoUrl);
    prefs.setBool('compReady', globals.data['compReady']);
    if (prefs.getStringList('favorites') == null)
      prefs.setStringList('favorites', []);
    debugPrint('FAVORITES: ' + prefs.getStringList('favorites').toString());
    displayName = prefs.getString('displayName');
    email = prefs.getString('email');
    photoUrl = prefs.getString('photoUrl');
    compReady = prefs.getBool('compReady');
    setState(() {});
  }

  void signOut() {
    final googleSignIn = GoogleSignIn();
    FirebaseAuth.instance.signOut();
    googleSignIn.signOut();
    router.navigateTo(context, '/login',
        transition: TransitionType.nativeModal, clearStack: true);
  }

  void navigateToMatchScout() {
    router.navigateTo(context, '/match_scout',
        transition: TransitionType.nativeModal);
  }

  void navigateToPitScout() {
    router.navigateTo(context, '/pit_scout',
        transition: TransitionType.nativeModal);
  }

  void navigateToMatchList() {
    router.navigateTo(context, '/match_list',
        transition: TransitionType.nativeModal);
  }

  void navigateToTeamList() {
    router.navigateTo(context, '/team_list',
        transition: TransitionType.nativeModal);
  }

  void navigateToFavoritesPage() {
    router.navigateTo(context, '/favorites',
        transition: TransitionType.nativeModal);
  }

  @override
  Widget build(BuildContext context) {
    if (compReady == false) {
      return new Scaffold(
        appBar: AppBar(title: Text('Home')),
        body: AlertDialog(
          title: Text('Status'),
          content: Text('Database is not competition ready.'),
          actions: <Widget>[
            FlatButton(
              child: Text('GO TO SIGN IN'),
              onPressed: signOut,
            )
          ],
        ),
      );
    }

    return new Scaffold(
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
                backgroundImage: CachedNetworkImageProvider(photoUrl),
              ),
            ),
            ListTile(
              title: Text('Matches'),
              leading: Icon(Icons.calendar_today),
              onTap: navigateToMatchList,
            ),
            ListTile(
              title: Text('Teams'),
              leading: Icon(Icons.people),
              onTap: navigateToTeamList,
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
              title: Text('Favorites'),
              leading: Icon(Icons.star),
              onTap: navigateToFavoritesPage,
            ),
            ListTile(
              title: Text('Scout Pro'),
              leading: Icon(Icons.assessment),
            ),
            ListTile(
              title: Text('Settings'),
              leading: Icon(Icons.settings),
            ),
            Divider(
              height: 20,
            ),
            ListTile(
              title: Text('Sign Out'),
              leading: Icon(Icons.arrow_back),
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
