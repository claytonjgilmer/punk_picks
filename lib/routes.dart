import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:punk_picks/pages/login.dart';
import 'package:punk_picks/pages/home.dart';
import 'package:punk_picks/pages/forms/match_scout.dart';
import 'package:punk_picks/pages/forms/pit_scout.dart';
import 'package:punk_picks/pages/match_list.dart';
import 'package:punk_picks/pages/team_list.dart';
import 'package:punk_picks/pages/first_pick.dart';
import 'package:punk_picks/pages/second_pick.dart';
import 'package:punk_picks/pages/fragments/match_summary.dart';

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

  router.define('/match_list', handler: new Handler(handlerFunc: (BuildContext context, params) {
    return new MatchListPage();
  }));

  router.define('/team_list', handler: new Handler(handlerFunc: (BuildContext context, params) {
    return new TeamListPage();
  }));

  router.define('/first_pick', handler: new Handler(handlerFunc: (BuildContext context, params) {
    return new FirstPickPage();
  }));

  router.define('/second_pick', handler: new Handler(handlerFunc: (BuildContext context, params) {
    return new SecondPickPage();
  }));

  router.define('/match_summary/:matchType/:matchNumber', handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    var matchType = params['matchType'][0];
    var matchNumber = params['matchNumber'][0];
    return new MatchSummaryPage(matchType, matchNumber);
  }));
/*
  router.define('/team_summary/:teamNumber', handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new TeamSummaryPage(params['teamNumber'][0]);
  }));

  router.define('/pit_summary/:teamNumber', handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new PitSummaryPage(params['teamNumber'][0]);
  }));
*/
}