import 'package:flutter/material.dart';
import 'package:punk_picks/pages/verify.dart';
import 'package:punk_picks/routes.dart';

void main() {
  defineRoutes();
  runApp(new MaterialApp(
    title: 'Punk Picks',
    theme: ThemeData(
      primaryColor: Colors.green[900],
    ),
    home: new VerifyPage(),
  ));
}