import 'package:esporty/src/data/models/game_model.dart';
import 'package:esporty/src/data/providers/firebase/firebase_provider.dart';
import 'package:esporty/src/data/repositories/player_repository.dart';

class GameRepository extends FirebaseProvider {
  final playerRepository = PlayerRepository();

  // setters
  Future<void> setGameData(GameModel gameModel) async {
    final result = getFirebaseDatabaseRef('games/$getCurrentUserId').push();
    await result.set(gameModel.toMap());
    playerRepository.addPlayerSelectedGame(result.key);
  }

  // getters
  Future<GameModel> getGameData(String playerId, String gameId) async {
    final result =
        await getFirebaseDatabaseRef('games/$playerId/$gameId').get();

    return GameModel.fromMap(result.value);
  }
}
