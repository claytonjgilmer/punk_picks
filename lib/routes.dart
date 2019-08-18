import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:punk_picks/pages/login.dart';
import 'package:punk_picks/pages/home.dart';
import 'package:punk_picks/pages/matchscout.dart';
import 'package:punk_picks/pages/pitscout.dart';

final router = Router();

void defineRoutes() {

  router.define('/login', handler: new Handler(handlerFunc: (BuildContext context, params) {
    return new LoginPage();
  }));

  router.define('/home', handler: new Handler(handlerFunc: (BuildContext context, params) {
    return new HomePage();
  }));  

  router.define('/match-scout', handler: new Handler(handlerFunc: (BuildContext context, params) {
    return new MatchScoutPage();
  }));

  router.define('/pit-scout', handler: new Handler(handlerFunc: (BuildContext context, params) {
    return new PitScoutPage();
  }));

}