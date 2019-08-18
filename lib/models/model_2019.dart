class Model2019 {
  // Starting level on HAB.
  int sandstormHabLevel;

  // True if bot leaves HAB during sandstorm.
  bool sandstormHabSuccess;

  // Number of hatches a bot places during sandstorm.
  int hatchesDuringSandstorm;

  // Number of cargo a bot places during sandstorm.
  int cargoDuringSandstorm;

  // Number of hatches a bot places during teleop.
  int hatchesDuringTeleop;

  // Number of cargo a bot places during teleop.
  int cargoDuringTeleop;

  // Max game piece placement height on rocket.
  int maxRocketPlacementHeight;

  // Where the bot ends up at the end.
  int endgameHabLevel;

  // If the bot scored a rocket RP
  bool rocketRP;

  // If the bot scored a climb RP
  bool climbRP;

  // Convert to JSON 
  Map<String, dynamic> toMap() {
    return {
      "sandstormHabLevel" : sandstormHabLevel,
      "sandstormHabSuccess" : sandstormHabSuccess ? 1 : 0,
      "hatchesDuringSandstorm" : hatchesDuringSandstorm,
      "cargoDuringSandstorm" : cargoDuringSandstorm,
      "hatchesDuringTeleop" : hatchesDuringTeleop,
      "cargoDuringTeleop" : cargoDuringTeleop,
      "maxRocketPlacementHeight" : maxRocketPlacementHeight,
      "endgameHabLevel" : endgameHabLevel,
      "rocketRP" : rocketRP ? 1 : 0,
      "climbRP" : climbRP ? 1 : 0
    };
  }
}
