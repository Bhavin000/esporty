part of 'game_cubit.dart';

abstract class GameState extends Equatable {
  const GameState();

  @override
  List<Object> get props => [];
}

class GameLoading extends GameState {}

class GameLoaded extends GameState {
  final List<GameModel> gameModels;
  const GameLoaded({required this.gameModels});

  @override
  List<Object> get props => [gameModels];

  Map<String, dynamic> toMap() {
    return {
      'gameModels': gameModels.map((x) => x.toMap()).toList(),
    };
  }

  factory GameLoaded.fromMap(Map<String, dynamic> map) {
    return GameLoaded(
      gameModels: List<GameModel>.from(
          map['gameModels']?.map((x) => GameModel.fromMap(x))),
    );
  }
}

class GameFailed extends GameState {}
