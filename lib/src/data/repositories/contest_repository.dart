import 'package:esporty/src/constants/games.dart';
import 'package:esporty/src/data/models/contest_model.dart';
import 'package:esporty/src/data/models/room_model.dart';
import 'package:esporty/src/data/providers/firebase/firebase_provider.dart';
import 'package:esporty/src/data/repositories/room_repository.dart';
import 'package:esporty/src/data/repositories/squad_repository.dart';
import 'package:firebase_database/firebase_database.dart';

class ContestRepository extends FirebaseProvider {
  final roomRepositoty = RoomRepositoty();
  final squadRepository = SquadRepository();

  getGameName(map) => games.keys.toList()[map['Select Game']];

  getGameMode(map) =>
      games[getGameName(map)]!.keys.toList()[map['Select Mode']];

  getGameMap(map) =>
      games[getGameName(map)]![getGameMode(map)]!.toList()[map['Select Map']];

  Future<void> createContest(Map<String, dynamic> contestDetail,
      String _contestType, String squadId) async {
    final contestModel = ContestModel(
      contestCreatedAt: DateTime.now(),
      contestCreatedBy: squadId,
      contestTitle: contestDetail['Enter Title'],
      contestDescription: contestDetail['Enter Description'],
      contestType: _contestType,
      contestVisibility: gameVisibility[contestDetail['Select Visibility']],
    );

    final roomModel = RoomModel(
      roomId: contestDetail['Enter Id'],
      password: contestDetail['Enter Password'],
      roomGameName: getGameName(contestDetail),
      roomGameMode: getGameMode(contestDetail),
      roomGameMap: getGameMap(contestDetail),
    );

    final result = getFirebaseDatabaseRef('contests').push();

    await result.set(contestModel.toMap());
    await squadRepository.addSquadUploadedContest(result.key);

    if (contestDetail['Select Visibility'] == 2) {
      print('enter invite only players details');
    }

    if (_contestType == 'room') {
      await roomRepositoty.createRoom(result.key, roomModel);
    } else if (_contestType == 'tournament') {
      print('create tournament');
    }
  }

  Stream<Event> contestListener() {
    return getFirebaseDatabaseRef('contests').onValue;
  }

  Future<void> deleteContest(String contestId) async {
    return await getFirebaseDatabaseRef('contests/$contestId').remove();
  }
}
