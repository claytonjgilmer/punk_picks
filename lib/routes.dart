import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:punk_picks/pages/login.dart';
import 'package:punk_picks/pages/home.dart';

final router = Router();

void defineRoutes() {
  router.define('/login', handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new LoginPage();
  }));

  router.define('/home', handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new HomePage();
  }));  
}