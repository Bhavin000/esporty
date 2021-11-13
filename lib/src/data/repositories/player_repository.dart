import 'package:esporty/src/data/models/player_model.dart';
import 'package:esporty/src/data/providers/firebase/firebase_provider.dart';
import 'package:esporty/src/data/repositories/authentication_repository.dart';
import 'package:firebase_database/firebase_database.dart';

class PlayerRepository extends FirebaseProvider {
  final authRepository = AuthenticationRepository();

  // setters
  Future<void> setPlayerName(String playerName) async {
    await getFirebaseDatabaseRef('players/$getCurrentUserId/playerName')
        .set(playerName);
  }

  Future<void> setPlayerProfileImg(String playerProfileImg) async {
    await getFirebaseDatabaseRef('players/$getCurrentUserId/playerProfileImg')
        .set(playerProfileImg);
  }

  Future<void> setPlayerSquadJoined(String playerSquadJoined) async {
    await getFirebaseDatabaseRef('players/$getCurrentUserId/playerSquadJoined')
        .set(playerSquadJoined);
  }

  // adders
  Future<void> addPlayerSelectedGame(String playerSelectedGame) async {
    await getFirebaseDatabaseRef(
            'players/$getCurrentUserId/playerSelectedGames')
        .push()
        .set(playerSelectedGame);
  }

  // getters
  Future<String> getPlayerName(String playerId) async {
    final result =
        await getFirebaseDatabaseRef('players/$playerId/playerName').get();

    return result.value.toString();
  }

  Future<String> getPlayerProfileImg(String playerId) async {
    final result =
        await getFirebaseDatabaseRef('players/$playerId/playerProfileImg')
            .get();

    return result.value.toString();
  }

  Future<List> getPlayerSelectedGames(String playerId) async {
    final result =
        await getFirebaseDatabaseRef('players/$playerId/playerSelectedGames')
            .get();

    final map = result.value;

    return map.values.toList();
  }

  Future<String> getplayerSquadJoined(String playerId) async {
    final result =
        await getFirebaseDatabaseRef('players/$playerId/playerSquadJoined')
            .get();

    return result.value.toString();
  }

  Future<PlayerModel> getPlayerDetails(String playerId) async {
    final _name = await getPlayerName(playerId);
    final _profileImg = await getPlayerProfileImg(playerId);
    final _selectedGames = await getPlayerSelectedGames(playerId);

    return PlayerModel(
      playerName: _name,
      playerProfileImg: _profileImg,
      playerSelectedGames: _selectedGames,
    );
  }

  // utils
  Future<void> isPlayerProfileCompleted() async {
    await getPlayerName(getCurrentUserId);
    await getPlayerProfileImg(getCurrentUserId);
    await getPlayerSelectedGames(getCurrentUserId);
  }

  requestSquadJoin(String squadId) async {
    await getFirebaseDatabaseRef('squads/$squadId/squadPlayersJoined')
        .push()
        .set(getCurrentUserId);
  }

  // listeners
  Stream<Event> playerSquadJoinedListener(String playerId) =>
      getFirebaseDatabaseRef('players/$playerId/playerSquadJoined').onValue;

  Stream<Event> playerListener(String playerId) =>
      getFirebaseDatabaseRef('players/$playerId').onValue;
}
