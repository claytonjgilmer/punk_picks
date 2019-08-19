import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:punk_picks/pages/login.dart';
import 'package:punk_picks/pages/home.dart';
import 'package:punk_picks/pages/match_scout.dart';
import 'package:punk_picks/pages/pit_scout.dart';

final router = Router();

void defineRoutes() {

  router.define('/login', handler: new Handler(handlerFunc: (BuildContext context, params) {
    return new LoginPage();
  }));

  router.define('/home', handler: new Handler(handlerFunc: (BuildContext context, params) {
    return new HomePage();
  }));  

  router.define('/match_scout', handler: new Handler(handlerFunc: (BuildContext context, params) {
    return new MatchScoutPage();
  }));

  router.define('/pit_scout', handler: new Handler(handlerFunc: (BuildContext context, params) {
    return new PitScoutPage();
  }));

}