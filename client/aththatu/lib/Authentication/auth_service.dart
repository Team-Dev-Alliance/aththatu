import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Sign up with email and password
  Future<String?> signUp({
    required String email,
    required String password,
    required bool isSeller,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null; // Success
    } on FirebaseAuthException catch (e) {
      return e.message; // Return error message
    }
  }

  // Sign in with email and password
  Future<String?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null; // Success
    } on FirebaseAuthException catch (e) {
      return e.message; // Return error message
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Stream to listen to authentication state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}