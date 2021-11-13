import 'package:esporty/src/data/providers/firebase/firebase_provider.dart';
import 'package:firebase_database/firebase_database.dart';

class ContestCloseRepository extends FirebaseProvider {
  Future<void> addContestApplied(String contestId, String squadId) async {
    return await getFirebaseDatabaseRef(
            'contestsClose/$contestId/contestApplied')
        .push()
        .set(squadId);
  }

  Future<void> addContestAccepted(String contestId, String squadId) async {
    return await getFirebaseDatabaseRef(
            'contestsClose/$contestId/contestAccepted')
        .push()
        .set(squadId);
  }

  Stream<Event> contestCloseListener(String contestId) =>
      getFirebaseDatabaseRef('contestsClose/$contestId').onValue;
}
