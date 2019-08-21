class ModelMatch2019 {
  // Name (first and last) of scout.
  String scoutName;

  // Type of match.
  // Qualification ('q')
  // Quarterfinals ('qf')
  // Semifinals ('sf')
  // Finals ('f')
  String matchType;

  // Match number.
  int matchNumber;

  // Team number.
  int teamNumber;

  // Alliance color.
  String allianceColor;

  // Scout notes.
  String scoutNotes;

///////////////////////////////////////////////////////////

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

  ModelMatch2019({
    this.scoutName,
    this.matchType,
    this.matchNumber,
    this.allianceColor,
    this.scoutNotes,
		this.sandstormHabLevel,
		this.sandstormHabSuccess,
		this.hatchesDuringSandstorm,
		this.cargoDuringSandstorm,
		this.hatchesDuringTeleop,
		this.cargoDuringTeleop,
    this.maxRocketPlacementHeight,
		this.endgameHabLevel,
		this.rocketRP,
		this.climbRP,
	});
}
