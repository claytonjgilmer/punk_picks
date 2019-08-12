import 'package:flutter/material.dart';
import 'package:punk_picks/pages/verify.dart';
import 'package:punk_picks/pages/login.dart';
import 'package:punk_picks/pages/home.dart';

void main() {
  runApp(new MaterialApp(
    title: 'Punk Picks',
    initialRoute: '/',
    theme: ThemeData(
      primaryColor: Colors.green[900],
    ),
    routes: {
      '/': (context) => VerifyPage(),
      '/login': (context) => LoginPage(),
      '/home': (context) => HomePage(),
    },
  ));
}