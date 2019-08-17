import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluro/fluro.dart';
import 'package:punk_picks/routes.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {

  var _user = FirebaseAuth.instance.currentUser();

  Future<void> _signIn() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } catch (e) {
      print(e); 
    }
    if (_user != null) {
      try {
        router.navigateTo(context, '/home', transition: TransitionType.fadeIn);
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign In')),
      body: ListView(
        children: <Widget>[
          Image.asset(
            'assets/stempunkslogo.png',
            height: 225,
            width: 225,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(100, 100, 100, 100),
            child: RaisedButton(
              child: Text('Sign in with Google'),
              onPressed: _signIn,
            )
          )
        ]
      ),
    );
  }
}

