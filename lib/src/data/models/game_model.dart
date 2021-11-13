import 'dart:convert';

class GameModel {
  String gameName;
  String gamePlayerId;

  GameModel({
    required this.gameName,
    required this.gamePlayerId,
  });

  Map<String, dynamic> toMap() {
    return {
      'gameName': gameName,
      'gamePlayerId': gamePlayerId,
    };
  }

  factory GameModel.fromMap(map) {
    return GameModel(
      gameName: map['gameName'],
      gamePlayerId: map['gamePlayerId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GameModel.fromJson(String source) =>
      GameModel.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GameModel &&
        other.gameName == gameName &&
        other.gamePlayerId == gamePlayerId;
  }

  @override
  int get hashCode => gameName.hashCode ^ gamePlayerId.hashCode;
}
