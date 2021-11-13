import 'dart:convert';

class RoomModel {
  String roomId;
  String password;
  String roomGameName;
  String roomGameMode;
  String roomGameMap;

  RoomModel({
    required this.roomId,
    required this.password,
    required this.roomGameName,
    required this.roomGameMode,
    required this.roomGameMap,
  });

  Map<String, dynamic> toMap() {
    return {
      'roomId': roomId,
      'password': password,
      'roomGameName': roomGameName,
      'roomGameMode': roomGameMode,
      'roomGameMap': roomGameMap,
    };
  }

  factory RoomModel.fromMap(map) {
    return RoomModel(
      roomId: map['roomId'],
      password: map['password'],
      roomGameName: map['roomGameName'],
      roomGameMode: map['roomGameMode'],
      roomGameMap: map['roomGameMap'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomModel.fromJson(String source) =>
      RoomModel.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RoomModel &&
        other.roomId == roomId &&
        other.password == password &&
        other.roomGameName == roomGameName &&
        other.roomGameMode == roomGameMode &&
        other.roomGameMap == roomGameMap;
  }

  @override
  int get hashCode {
    return roomId.hashCode ^
        password.hashCode ^
        roomGameName.hashCode ^
        roomGameMode.hashCode ^
        roomGameMap.hashCode;
  }
}
