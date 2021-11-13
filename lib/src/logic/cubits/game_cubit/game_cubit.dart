import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:esporty/src/data/models/game_model.dart';
import 'package:esporty/src/data/repositories/game_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> with HydratedMixin {
  final GameRepository gameRepository;
  GameCubit({
    required this.gameRepository,
  }) : super(GameLoading());

  Future<void> addGame(GameModel gameModel) async {
    await gameRepository.setGameData(gameModel);
  }

  void getGame(List gameIds) async {
    emitGameLoading();
    try {
      List<GameModel> result = [];
      for (dynamic gameId in gameIds) {
        final out = await gameRepository.getGameData(
          gameRepository.getCurrentUserId,
          gameId,
        );
        result.add(out);
      }
      emitGameLoaded(result);
    } catch (e) {
      emitGameFailed();
    }
  }

  emitGameLoading() => emit(GameLoading());
  emitGameLoaded(_gameModels) => emit(GameLoaded(gameModels: _gameModels));
  emitGameFailed() => emit(GameFailed());

  @override
  GameState? fromJson(Map<String, dynamic> json) {
    if (json.isNotEmpty) return GameLoaded.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(GameState state) {
    if (state is GameLoaded) return state.toMap();
  }
}
