import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:punk_picks/pages/login.dart';
import 'package:punk_picks/pages/home.dart';
import 'package:punk_picks/pages/forms/match_scout.dart';
import 'package:punk_picks/pages/forms/pit_scout.dart';
import 'package:punk_picks/pages/fragments/match_list.dart';
import 'package:punk_picks/pages/fragments/rmd_list.dart';
import 'package:punk_picks/pages/team_list.dart';
import 'package:punk_picks/pages/first_pick.dart';
import 'package:punk_picks/pages/second_pick.dart';
import 'package:punk_picks/pages/fragments/match_summary.dart';
import 'package:punk_picks/pages/fragments/rmd_summary.dart';

final router = Router();

void defineRoutes() {

  router.define('/login', handler: new Handler(handlerFunc: (BuildContext context, params) {
    return new LoginPage();
  }));

  router.define('/home', handler: new Handler(handlerFunc: (BuildContext context, params) {
    return new HomePage();
  }));  

  // Match scouting page
  router.define('/match_scout', handler: new Handler(handlerFunc: (BuildContext context, params) {
    return new MatchScoutPage();
  }));

  // Pit scouting page
  router.define('/pit_scout', handler: new Handler(handlerFunc: (BuildContext context, params) {
    return new PitScoutPage();
  }));

  // Unfiltered match list page, so if selected from home page
  router.define('/match_list', handler: new Handler(handlerFunc: (BuildContext context, params) {
    return new MatchListPage();
  }));

  // Filtered match list page, if selected from team summary page (filter by team)
  router.define('/match_list/:teamNumber', handler: new Handler(handlerFunc: (BuildContext context, params) {
    var teamNumber = params['teamNumber'][0];
    return new MatchListPage(teamNumber);
  }));

  // Team list page
  router.define('/team_list', handler: new Handler(handlerFunc: (BuildContext context, params) {
    return new TeamListPage();
  }));

  // Raw match data (submitted scouting results) list page, filter by team
  router.define('/rmd_list/:teamNumber', handler: new Handler(handlerFunc: (BuildContext context, params) {
    var teamNumber = params['teamNumber'][0];
    return new RmdListPage.fromTeam(teamNumber);
  }));

  // Raw match data (submitted scouting results) list page, filter by specific match
  router.define('/rmd_list/:matchType/:matchNumber', handler: new Handler(handlerFunc: (BuildContext context, params) {
    var matchType = params['matchType'][0];
    var matchNumber = params['matchNumber'][0];
    return new RmdListPage(matchType, matchNumber);
  }));

  // First pick list, contains list of all teams and sorts by first-pickability
  router.define('/first_pick', handler: new Handler(handlerFunc: (BuildContext context, params) {
    return new FirstPickPage();
  }));

  // Second pick list, contains list of all teams and sorts by second-pickability
  router.define('/second_pick', handler: new Handler(handlerFunc: (BuildContext context, params) {
    return new SecondPickPage();
  }));

  // Match summary page, gives general match summary (most data from tba)
  router.define('/match_summary/:matchType/:matchNumber', handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    var matchType = params['matchType'][0];
    var matchNumber = params['matchNumber'][0];
    return new MatchSummaryPage(matchType, matchNumber);
  }));

  // Team summary page, data from tba and punk server calc data
  router.define('/rmd_summary/:teamNumber/:matchType/:matchNumber', handler: new Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    var teamNumber = params['teamNumber'][0];
    var matchType = params['matchType'][0];
    var matchNumber = params['matchNumber'][0];
    return new RmdSummaryPage(teamNumber, matchType, matchNumber);
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