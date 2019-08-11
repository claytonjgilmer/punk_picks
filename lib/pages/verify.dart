import 'package:flutter/material.dart';
import 'package:punk_picks/auth.dart';
import 'package:punk_picks/provider.dart';

class VerifyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Auth auth = Provider.of(context).auth;
    return StreamBuilder<String>(
      stream: auth.onAuthStateChanged,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool loggedIn = snapshot.hasData;
          if (loggedIn == true) {
            Navigator.pushNamed(context, '/home');
          } else {
            Navigator.pushNamed(context, '/login');
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}