import 'package:esporty/src/data/models/chat_model.dart';
import 'package:esporty/src/data/providers/firebase/firebase_provider.dart';
import 'package:esporty/src/data/repositories/player_repository.dart';
import 'package:firebase_database/firebase_database.dart';

class ChatRepository extends FirebaseProvider {
  final playerRepository = PlayerRepository();

  // setters
  Future<void> addChatData(String chatData) async {
    final result =
        await playerRepository.getplayerSquadJoined(getCurrentUserId);

    final chatModel =
        ChatModel(chatCreatedBy: getCurrentUserId, message: chatData);

    await getFirebaseDatabaseRef('chats/$result').push().set(chatModel.toMap());
  }

  Stream<Event> chatListener(String squadId) {
    return getFirebaseDatabaseRef('chats/$squadId').onValue;
  }
}
