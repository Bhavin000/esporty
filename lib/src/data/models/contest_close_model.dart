import 'dart:convert';

import 'package:flutter/foundation.dart';

class ContestCloseModel {
  List contestApplied;
  List contestAccepted;

  ContestCloseModel({
    required this.contestApplied,
    required this.contestAccepted,
  });

  Map<String, dynamic> toMap() {
    return {
      'contestApplied': contestApplied,
      'contestAccepted': contestAccepted,
    };
  }

  factory ContestCloseModel.fromMap(map) {
    return ContestCloseModel(
      contestApplied: map.containsKey('contestApplied')
          ? map['contestApplied'].values.toList()
          : [],
      contestAccepted: map.containsKey('contestAccepted')
          ? map['contestAccepted'].values.toList()
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory ContestCloseModel.fromJson(String source) =>
      ContestCloseModel.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ContestCloseModel &&
        listEquals(other.contestApplied, contestApplied) &&
        listEquals(other.contestAccepted, contestAccepted);
  }

  @override
  int get hashCode => contestApplied.hashCode ^ contestAccepted.hashCode;
}
