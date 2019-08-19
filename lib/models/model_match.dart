class ModelMatch {
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

  ModelMatch({
    this.scoutName,
    this.matchType,
    this.matchNumber,
    this.teamNumber,
    this.allianceColor,
    this.scoutNotes,
  });
}
