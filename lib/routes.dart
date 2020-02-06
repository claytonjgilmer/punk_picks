import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:punk_picks/pages/favorites.dart';
import 'package:punk_picks/pages/login.dart';
import 'package:punk_picks/pages/home.dart';
import 'package:punk_picks/pages/forms/match_scout.dart';
import 'package:punk_picks/pages/forms/pit_scout.dart';
import 'package:punk_picks/pages/match_list.dart';
import 'package:punk_picks/pages/settings.dart';
import 'package:punk_picks/pages/team_list.dart';
import 'package:punk_picks/pages/first_pick.dart';
import 'package:punk_picks/pages/second_pick.dart';
import 'package:punk_picks/pages/scout_pro.dart';
import 'package:punk_picks/pages/fragments/match_summary_fragment.dart';
import 'package:punk_picks/pages/fragments/rmd_summary_fragment.dart';
import 'package:punk_picks/pages/fragments/team_summary.dart';

final router = Router();

void defineRoutes() {
  router.define('/login',
      handler: new Handler(handlerFunc: (BuildContext context, params) {
    return new LoginPage();
  }));

  router.define('/home',
      handler: new Handler(handlerFunc: (BuildContext context, params) {
    return new HomePage();
  }));

  // Match scouting page
  router.define('/match_scout',
      handler: new Handler(handlerFunc: (BuildContext context, params) {
    return new MatchScoutPage();
  }));

  // Pit scouting page
  router.define('/pit_scout',
      handler: new Handler(handlerFunc: (BuildContext context, params) {
    return new PitScoutPage();
  }));

  // Unfiltered match list page, so if selected from home page
  router.define('/match_list',
      handler: new Handler(handlerFunc: (BuildContext context, params) {
    return new MatchListPage();
  }));

  // Team list page
  router.define('/team_list',
      handler: new Handler(handlerFunc: (BuildContext context, params) {
    return new TeamListPage();
  }));

  // First pick list, contains list of all teams and sorts by first-pickability
  router.define('/first_pick',
      handler: new Handler(handlerFunc: (BuildContext context, params) {
    return new FirstPickPage();
  }));

  // Second pick list, contains list of all teams and sorts by second-pickability
  router.define('/second_pick',
      handler: new Handler(handlerFunc: (BuildContext context, params) {
    return new SecondPickPage();
  }));

  // Favorites page, displays user's saved teams
  router.define('/favorites',
      handler: new Handler(handlerFunc: (BuildContext context, params) {
    return new FavoritesPage();
  }));

  router.define('/scout_pro',
      handler: new Handler(handlerFunc: (BuildContext context, params) {
    return new ScoutProPage();
  }));

  // Settings page, allows user to set preferences
  router.define('/settings',
      handler: new Handler(handlerFunc: (BuildContext context, params) {
    return new SettingsPage();
  }));

  // Match summary page, gives general match summary (most data from tba)
  router.define('/match_summary/:matchType/:matchNumber', handler: new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    var matchType = params['matchType'][0];
    var matchNumber = params['matchNumber'][0];
    return new MatchSummaryPage(matchType, matchNumber);
  }));

  // Raw match data summary page
  router.define('/rmd_summary/:teamNumber/:matchType/:matchNumber', handler:
      new Handler(
          handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    var teamNumber = params['teamNumber'][0];
    var matchType = params['matchType'][0];
    var matchNumber = params['matchNumber'][0];
    return new RmdSummaryPage(teamNumber, matchType, matchNumber);
  }));

  // Team summary page, data from tba and punk server calc data
  router.define('/team_summary/:teamNumber', handler: new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    var teamNumber = params['teamNumber'][0];
    return new TeamSummaryPage(teamNumber);
  }));
}
