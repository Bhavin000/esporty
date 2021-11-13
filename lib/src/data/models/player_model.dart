import 'dart:convert';

import 'package:flutter/foundation.dart';

class PlayerModel {
  String playerName;
  String playerProfileImg;
  List playerSelectedGames;
  String? playerSquadJoined;
  List? playerSquadsInvited;

  PlayerModel({
    required this.playerName,
    required this.playerProfileImg,
    required this.playerSelectedGames,
    this.playerSquadJoined,
    this.playerSquadsInvited,
  });

  Map<String, dynamic> toMap() {
    return {
      'playerName': playerName,
      'playerProfileImg': playerProfileImg,
      'playerSelectedGames': playerSelectedGames,
      'playerSquadJoined': playerSquadJoined,
      'playerSquadsInvited': playerSquadsInvited,
    };
  }

  factory PlayerModel.fromMap(map) {
    return PlayerModel(
      playerName: map['playerName'],
      playerProfileImg: map['playerProfileImg'],
      playerSelectedGames: map['playerSelectedGames'] is List
          ? map['playerSelectedGames']
          : map['playerSelectedGames'].values.toList(),
      playerSquadJoined:
          map.containsKey('playerSquadJoined') ? map['playerSquadJoined'] : '',
      playerSquadsInvited: map.containsKey('playerSquadsInvited')
          ? map['playerSquadsInvited'] is List
              ? map['playerSquadsInvited']
              : map['playerSquadsInvited'].values.toList()
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory PlayerModel.fromJson(String source) =>
      PlayerModel.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PlayerModel &&
        other.playerName == playerName &&
        other.playerProfileImg == playerProfileImg &&
        listEquals(other.playerSelectedGames, playerSelectedGames) &&
        other.playerSquadJoined == playerSquadJoined &&
        listEquals(other.playerSquadsInvited, playerSquadsInvited);
  }

  @override
  int get hashCode {
    return playerName.hashCode ^
        playerProfileImg.hashCode ^
        playerSelectedGames.hashCode ^
        playerSquadJoined.hashCode ^
        playerSquadsInvited.hashCode;
  }
}
