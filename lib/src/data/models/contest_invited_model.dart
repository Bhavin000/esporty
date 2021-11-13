import 'dart:convert';

import 'package:flutter/foundation.dart';

class ContestInvitedModel {
  List contestInvited;
  List contestAccpeted;

  ContestInvitedModel({
    required this.contestInvited,
    required this.contestAccpeted,
  });

  Map<String, dynamic> toMap() {
    return {
      'contestInvited': contestInvited,
      'contestAccpeted': contestAccpeted,
    };
  }

  factory ContestInvitedModel.fromMap(Map<String, dynamic> map) {
    return ContestInvitedModel(
      contestInvited: List.from(map['contestInvited']),
      contestAccpeted: List.from(map['contestAccpeted']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ContestInvitedModel.fromJson(String source) =>
      ContestInvitedModel.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ContestInvitedModel &&
        listEquals(other.contestInvited, contestInvited) &&
        listEquals(other.contestAccpeted, contestAccpeted);
  }

  @override
  int get hashCode => contestInvited.hashCode ^ contestAccpeted.hashCode;
}
