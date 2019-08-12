import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {

  var _user = FirebaseAuth.instance.currentUser();
  final _LoginFormKey = GlobalKey<FormState>();

  Future<void> _signIn() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } catch (e) {
      print(e); 
    }
    if (_user != null) {
      try {
        Navigator.pushReplacementNamed(context, '/home');
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
          Form(
            key: _LoginFormKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    icon: Icon(Icons.mail)
                  ),
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    icon: Icon(Icons.lock)
                  )
                ),
                RaisedButton(
                  child: Text('Log In'),
                  onPressed: null,
                )
              ],
            ),
          )
        ]
      ),
    );
  }
}

