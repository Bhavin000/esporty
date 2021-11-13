import 'package:esporty/src/data/models/room_model.dart';
import 'package:esporty/src/data/providers/firebase/firebase_provider.dart';

class RoomRepositoty extends FirebaseProvider {
  Future<void> createRoom(String roomId, RoomModel roomModel) async {
    return await getFirebaseDatabaseRef('rooms/$roomId').set(roomModel.toMap());
  }

  Future<RoomModel> getRoomDetails(String roomId) async {
    final result = await getFirebaseDatabaseRef('rooms/$roomId').get();
    return RoomModel.fromMap(result.value);
  }
}
