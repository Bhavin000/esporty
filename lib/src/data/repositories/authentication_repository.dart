import 'package:esporty/src/data/providers/firebase/firebase_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepository extends FirebaseProvider {
  Future<UserCredential> emailSignup(String _email, String _password) async {
    UserCredential userCredential =
        await getAuth.createUserWithEmailAndPassword(
      email: _email,
      password: _password,
    );
    return userCredential;
  }

  Future<void> verifyEmail() async {
    await getCurrentUser!.sendEmailVerification();
  }

  Future<UserCredential> emailSignIn(String _email, String _password) async {
    UserCredential userCredential = await getAuth.signInWithEmailAndPassword(
      email: _email,
      password: _password,
    );
    return userCredential;
  }

  Future<UserCredential> googleSignIn() async {
    final googleUser = await GoogleSignIn().signIn();

    final googleAuth = await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return await getAuth.signInWithCredential(credential);
  }

  void signOut() async {
    await getAuth.signOut();
  }

  Stream<User?> userChangesListener() => getAuth.userChanges();
}
