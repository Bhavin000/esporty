import 'dart:convert';

import 'package:flutter/foundation.dart';

class SquadModel {
  String? squadId;
  String squadCreatedBy; // auto
  String squadName;
  String squadProfileImg;
  String squadSelectedGame;
  bool squadIsVerified; // auto
  List squadPlayersJoined;
  List squadUploadedContests;
  List squadAppliedContests;
  List squadInvitedContests;

  SquadModel({
    required this.squadCreatedBy,
    required this.squadName,
    required this.squadProfileImg,
    required this.squadSelectedGame,
    required this.squadIsVerified,
    required this.squadPlayersJoined,
    required this.squadUploadedContests,
    required this.squadAppliedContests,
    required this.squadInvitedContests,
  });

  Map<String, dynamic> toMap() {
    return {
      'squadCreatedBy': squadCreatedBy,
      'squadName': squadName,
      'squadProfileImg': squadProfileImg,
      'squadSelectedGame': squadSelectedGame,
      'squadIsVerified': squadIsVerified,
      'squadPlayersJoined': squadPlayersJoined,
      'squadUploadedContests': squadUploadedContests,
      'squadAppliedContests': squadAppliedContests,
      'squadInvitedContests': squadInvitedContests,
    };
  }

  factory SquadModel.fromMap(map) {
    return SquadModel(
      squadCreatedBy: map['squadCreatedBy'],
      squadName: map['squadName'],
      squadProfileImg: map['squadProfileImg'],
      squadSelectedGame: map['squadSelectedGame'],
      squadIsVerified: map['squadIsVerified'],
      squadPlayersJoined: map.containsKey('squadPlayersJoined')
          ? map['squadPlayersJoined'].values.toList()
          : [],
      squadUploadedContests: map.containsKey('squadUploadedContests')
          ? map['squadUploadedContests'].values.toList()
          : [],
      squadAppliedContests: map.containsKey('squadAppliedContests')
          ? map['squadAppliedContests'].values.toList()
          : [],
      squadInvitedContests: map.containsKey('squadInvitedContests')
          ? map['squadInvitedContests'].values.toList()
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory SquadModel.fromJson(String source) =>
      SquadModel.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SquadModel &&
        other.squadId == squadId &&
        other.squadCreatedBy == squadCreatedBy &&
        other.squadName == squadName &&
        other.squadProfileImg == squadProfileImg &&
        other.squadSelectedGame == squadSelectedGame &&
        other.squadIsVerified == squadIsVerified &&
        listEquals(other.squadPlayersJoined, squadPlayersJoined) &&
        listEquals(other.squadUploadedContests, squadUploadedContests) &&
        listEquals(other.squadAppliedContests, squadAppliedContests) &&
        listEquals(other.squadInvitedContests, squadInvitedContests);
  }

  @override
  int get hashCode {
    return squadId.hashCode ^
        squadCreatedBy.hashCode ^
        squadName.hashCode ^
        squadProfileImg.hashCode ^
        squadSelectedGame.hashCode ^
        squadIsVerified.hashCode ^
        squadPlayersJoined.hashCode ^
        squadUploadedContests.hashCode ^
        squadAppliedContests.hashCode ^
        squadInvitedContests.hashCode;
  }
}
