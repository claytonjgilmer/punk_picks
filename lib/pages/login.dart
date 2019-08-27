import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fluro/fluro.dart';
import 'package:punk_picks/routes.dart';

class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  signIn() async {
    try {
      final googleSignIn = GoogleSignIn();
      final GoogleSignInAccount googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .whenComplete(() {
        router.navigateTo(context, '/home',
            transition: TransitionType.fadeIn, clearStack: true);
      });
    } catch (e) {
      debugPrint('ERROR: ' + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign In')),
      body: ListView(children: <Widget>[
        Image.asset(
          'assets/stempunkslogo.png',
          height: 225,
          width: 225,
        ),
        Padding(
            padding: EdgeInsets.fromLTRB(100, 40, 100, 100),
            child: RaisedButton(
              child: Text('Sign in with Google'),
              onPressed: signIn,
            ))
      ]),
    );
  }
}
