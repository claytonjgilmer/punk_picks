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

  // Convert to JSON for firebase upload
  Map<String, dynamic> toMap() {
    return {
      "scoutName" : this.scoutName,
      "matchType" : this.matchType,
      "matchNumber" : this.matchNumber,
      "teamNumber" : this.teamNumber,
      "alliance" : this.allianceColor
    };
  }
}
