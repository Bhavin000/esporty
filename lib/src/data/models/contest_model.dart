import 'dart:convert';

class ContestModel {
  String? contestId;
  String contestCreatedBy;
  DateTime contestCreatedAt;
  String contestTitle;
  String contestDescription;
  String contestType; // room, tournament
  String contestVisibility; // open, close, invite only

  ContestModel({
    required this.contestCreatedBy,
    required this.contestCreatedAt,
    required this.contestTitle,
    required this.contestDescription,
    required this.contestType,
    required this.contestVisibility,
  });

  Map<String, dynamic> toMap() {
    return {
      'contestCreatedBy': contestCreatedBy,
      'contestCreatedAt': contestCreatedAt.toString(),
      'contestTitle': contestTitle,
      'contestDescription': contestDescription,
      'contestType': contestType,
      'contestVisibility': contestVisibility,
    };
  }

  factory ContestModel.fromMap(map) {
    return ContestModel(
      contestCreatedBy: map['contestCreatedBy'],
      contestCreatedAt: DateTime.parse(map['contestCreatedAt']),
      contestTitle: map['contestTitle'],
      contestDescription: map['contestDescription'],
      contestType: map['contestType'],
      contestVisibility: map['contestVisibility'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ContestModel.fromJson(String source) =>
      ContestModel.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ContestModel &&
        other.contestCreatedBy == contestCreatedBy &&
        other.contestCreatedAt.toString() == contestCreatedAt.toString() &&
        other.contestTitle == contestTitle &&
        other.contestDescription == contestDescription &&
        other.contestType == contestType &&
        other.contestVisibility == contestVisibility;
  }

  @override
  int get hashCode {
    return contestCreatedBy.hashCode ^
        contestCreatedAt.hashCode ^
        contestTitle.hashCode ^
        contestDescription.hashCode ^
        contestType.hashCode ^
        contestVisibility.hashCode;
  }
}
