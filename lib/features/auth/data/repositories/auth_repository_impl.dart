import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/firebase_auth_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthSource firebaseAuthSource;

  AuthRepositoryImpl(this.firebaseAuthSource);

  @override
  Future<User?> login(String email, String password) {
    return firebaseAuthSource.loginWithEmail(email, password);
  }

  @override
  Future<User?> register(String email, String password) {
    return firebaseAuthSource.registerWithEmail(email, password);
  }

    @override
  Future<void> googleSignIn() async {
    await firebaseAuthSource.signInWithGoogle();
  }

  @override
  Future<void> logout() {
    return firebaseAuthSource.logout();
  }

  @override
  Stream<User?> get userChanges => firebaseAuthSource.userChanges;
}
