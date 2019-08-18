import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fluro/fluro.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:punk_picks/routes.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {

  _signIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var _user = await FirebaseAuth.instance.currentUser();
    final _googleSignIn = GoogleSignIn();
    final GoogleSignInAccount _googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: _googleAuth.accessToken,
      idToken: _googleAuth.idToken,
    );
    FirebaseAuth.instance.signInWithCredential(credential);
    if ( _user != null) {
      await prefs.setString('id', _user.uid);
      await prefs.setString('displayName', _user.displayName);
      await prefs.setString('email', _user.email);
      await prefs.setString('photoUrl', _user.photoUrl);

      router.navigateTo(context, '/home', transition: TransitionType.fadeIn, clearStack: true);
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
            padding: EdgeInsets.fromLTRB(100, 40, 100, 100),
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

