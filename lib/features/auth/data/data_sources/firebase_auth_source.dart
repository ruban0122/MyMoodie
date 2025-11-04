import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthSource {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  FirebaseAuthSource(this._firebaseAuth);

  Future<User?> registerWithEmail(String email, String password) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  Future<User?> loginWithEmail(String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  Future<User?> signInWithGoogle() async {
    // Trigger Google Sign-In flow
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return null; // user canceled sign in

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential =
        await _firebaseAuth.signInWithCredential(credential);
    return userCredential.user;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await googleSignIn.signOut();
  }

  User? get currentUser => _firebaseAuth.currentUser;

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  Stream<User?> get userChanges => _firebaseAuth.authStateChanges();
}
