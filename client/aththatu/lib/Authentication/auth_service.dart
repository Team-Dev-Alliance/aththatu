import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Sign up with email and password
  Future<String?> signUp({
    required String email,
    required String password,
    required String fullName,
    required String userType,
  }) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Save initial user details to Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'fullName': fullName,
        'email': email,
        'userType': userType,
        'createdAt': Timestamp.now(),
      });
      return null; // Success
    } on FirebaseAuthException catch (e) {
      return e.message; // Return error message
    }
  }

  // Save additional user details
  Future<void> saveUserDetails({
    required String uid,
    required String nicNumber,
    required String dateOfBirth,
    required String address,
    required String postalCode,
    required String phoneNumber,
    String? licenseNumber,
    String? licenseDocumentUrl,
  }) async {
    final userData = {
      'nicNumber': nicNumber,
      'dateOfBirth': dateOfBirth,
      'address': address,
      'postalCode': postalCode,
      'phoneNumber': phoneNumber,
    };
    if (licenseNumber != null) {
      userData['licenseNumber'] = licenseNumber;
    }
    if (licenseDocumentUrl != null) {
      userData['licenseDocumentUrl'] = licenseDocumentUrl;
    }
    await _firestore.collection('users').doc(uid).update(userData);
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