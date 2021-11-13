import 'dart:io';

import 'package:esporty/src/data/providers/firebase/firebase_provider.dart';
import 'package:image_picker/image_picker.dart';

class UtilRepository extends FirebaseProvider {
  Future<String> setPlayerProfileImg() async {
    ImagePicker _picker = ImagePicker();
    final img = await _picker.pickImage(source: ImageSource.gallery);
    File imgFile = File(img!.path);
    final uploadedImg =
        await getFirebaseStorageRef('playerProfileImg/${img.name}')
            .putFile(imgFile);
    return await uploadedImg.ref.getDownloadURL();
  }

  Future<String> setSquadProfileImg() async {
    ImagePicker _picker = ImagePicker();
    final img = await _picker.pickImage(source: ImageSource.gallery);
    File imgFile = File(img!.path);
    final uploadedImg =
        await getFirebaseStorageRef('squadProfileImg/${img.name}')
            .putFile(imgFile);
    return await uploadedImg.ref.getDownloadURL();
  }
}
