class ModelMatch {
  // Name (first and last) of scout.
  String scoutName;

  // Type of match.
  // Qualifiers ('q')
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

  ModelMatch({
    this.scoutName,
    this.matchType,
    this.matchNumber,
    this.teamNumber,
    this.allianceColor
  });
}
