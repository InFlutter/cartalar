import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final authService = FirebaseAuth.instance;

  Future<void> register(String email, String password) async {
    try {
      await authService.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }
}
