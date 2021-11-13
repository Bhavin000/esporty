import 'dart:convert';

import 'package:esporty/src/data/models/squad_model.dart';
import 'package:esporty/src/data/providers/firebase/firebase_provider.dart';
import 'package:esporty/src/data/providers/shared_preferences/shared_preferences_provider.dart';
import 'package:esporty/src/data/repositories/chat_repository.dart';
import 'package:esporty/src/data/repositories/contest_close_repository.dart';
import 'package:esporty/src/data/repositories/player_repository.dart';
import 'package:firebase_database/firebase_database.dart';

class SquadRepository extends FirebaseProvider {
  final playerRepository = PlayerRepository();
  final chatRepository = ChatRepository();
  final contestCloseRepository = ContestCloseRepository();
  final sharedPreferencesProvider = SharedPreferencesProvider();

  Future<void> createSquad(
      String squadName, String imageUrl, String gameName) async {
    final result = getFirebaseDatabaseRef('squads').push();

    await result.set({
      'squadCreatedBy': getCurrentUserId,
      'squadName': squadName,
      'squadProfileImg': imageUrl,
      'squadSelectedGame': gameName,
      'squadIsVerified': false,
    });

    playerRepository.setPlayerSquadJoined(result.key);
  }

  Future<void> isSquadDetailsCompleted() async {
    final squadId =
        await playerRepository.getplayerSquadJoined(getCurrentUserId);

    await getFirebaseDatabaseRef('squads/$squadId/squadCreatedBy').get();
    await getFirebaseDatabaseRef('squads/$squadId/squadName').get();
    await getFirebaseDatabaseRef('squads/$squadId/squadProfileImg').get();
    await getFirebaseDatabaseRef('squads/$squadId/squadSelectedGame').get();
    await getFirebaseDatabaseRef('squads/$squadId/squadIsVerified').get();
  }

  // adders
  Future<void> addSquadUploadedContest(String squadUploadedContest) async {
    final result =
        await playerRepository.getplayerSquadJoined(getCurrentUserId);

    await getFirebaseDatabaseRef('squads/$result/squadUploadedContests')
        .push()
        .set(squadUploadedContest);
  }

  Future<void> addSquadAppliedContest(
      String squadAppliedContest, String squadId) async {
    final result =
        await playerRepository.getplayerSquadJoined(getCurrentUserId);

    await getFirebaseDatabaseRef('squads/$result/squadAppliedContests')
        .push()
        .set(squadAppliedContest);

    await contestCloseRepository.addContestApplied(
        squadAppliedContest, squadId);
  }

  // getters
  Future<SquadModel> getSquadDetails(String squadId) async {
    if (await sharedPreferencesProvider.containsKey(squadId)) {
      return SquadModel.fromJson(
          await sharedPreferencesProvider.getData(squadId));
    }
    final result = await getFirebaseDatabaseRef('squads/$squadId').get();
    sharedPreferencesProvider.setData(squadId, json.encode(result.value));
    return SquadModel.fromMap(result.value);
  }

  Future<List<SquadModel>> getAllSquads() async {
    final result = await getFirebaseDatabaseRef('squads').get();
    final squadsKey = result.value.keys.toList();

    List<SquadModel> listSquadModel = [];

    for (dynamic key in squadsKey) {
      final model = SquadModel.fromMap(result.value[key]);
      model.squadId = key;
      listSquadModel.add(model);
    }
    return listSquadModel;
  }

  // utils
  Future<void> invitePlayerInSquad(String playerId) async {
    final result =
        await playerRepository.getplayerSquadJoined(getCurrentUserId);

    await getFirebaseDatabaseRef('players/$playerId/playerSquadsInvited')
        .push()
        .set(result);
  }

  Future<void> acceptPlayerJoined(String squadId, String playerId) async {
    return await getFirebaseDatabaseRef('players/$playerId/playerSquadJoined')
        .set(squadId);
  }

  // listeners
  Stream<Event> squadListener(String squadId) =>
      getFirebaseDatabaseRef('squads/$squadId').onValue;
}
