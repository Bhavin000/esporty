part of 'player_cubit.dart';

abstract class PlayerState extends Equatable {
  const PlayerState();

  @override
  List<Object> get props => [];
}

class PlayerLoading extends PlayerState {}

class PlayerSucceed extends PlayerState {
  final PlayerModel playerModel;
  const PlayerSucceed({required this.playerModel});

  @override
  List<Object> get props => [playerModel];

  Map<String, dynamic> toMap() {
    return {
      'playerModel': playerModel.toMap(),
    };
  }

  factory PlayerSucceed.fromMap(Map<String, dynamic> map) {
    return PlayerSucceed(
      playerModel: PlayerModel.fromMap(map['playerModel']),
    );
  }
}

class PlayerFailed extends PlayerState {}
