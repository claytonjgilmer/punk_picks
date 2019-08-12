import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// This page exists in order to bypass login screen after app quit for users who have already signed in

class VerifyPage extends StatefulWidget {
  @override
  _VerifyPageState createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  @override
  void initState() {
    super.initState();
    verifyLogin();
  }

  Future<void> verifyLogin() async {
    var user = await FirebaseAuth.instance.currentUser();
    if (user != null) {
      Navigator.pushNamed(context, '/home');
    } else {
      Navigator.pushNamed(context, '/login');
    }
  }


  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}