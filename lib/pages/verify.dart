import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluro/fluro.dart';
import 'package:punk_picks/routes.dart';

// This page exists in order to bypass login screen after app quit for users who have already signed in

class VerifyPage extends StatefulWidget {
  _VerifyPageState createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  @override
  void initState() {
    super.initState();
    verifyLogin();
  }

  verifyLogin() async {
    var user = await FirebaseAuth.instance.currentUser();
    if (user != null) {
      router.navigateTo(context, '/home',
          transition: TransitionType.fadeIn, clearStack: true);
    } else {
      router.navigateTo(context, '/login',
          transition: TransitionType.fadeIn, clearStack: true);
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
