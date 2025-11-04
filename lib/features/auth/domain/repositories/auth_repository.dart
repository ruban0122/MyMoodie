import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<User?> login(String email, String password);
  Future<User?> register(String email, String password);
  Future<void> googleSignIn(); // 👈 Add this

  Future<void> logout();
  Stream<User?> get userChanges;
}
