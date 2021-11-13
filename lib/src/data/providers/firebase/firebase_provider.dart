import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseProvider {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  static FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  static FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;

  // getters //
  FirebaseAuth get getAuth => auth;
  User? get getCurrentUser => auth.currentUser;
  String get getCurrentUserId => auth.currentUser!.uid;

  // firestore reference //
  CollectionReference getCollectionReference(
    String collection,
  ) {
    return firebaseFirestore.collection(collection);
  }

  DocumentReference getDocumentReference(
    String collection,
    String document,
  ) {
    return firebaseFirestore.collection(collection).doc(document);
  }

  // firebase storage reference //
  Reference getFirebaseStorageRef(
    String file,
  ) {
    return firebaseStorage.ref(file);
  }

  // firebase database (realtime db)
  DatabaseReference getFirebaseDatabaseRef(String child) {
    return firebaseDatabase.reference().child(child);
  }
}
