import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GoogleAuthService {
  final FirebaseAuth auth;

  GoogleAuthService({required this.auth});

  Future<User?> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        // Web sign-in
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        final userCredential = await auth.signInWithPopup(googleProvider);
        return userCredential.user;
      } else {
        // Mobile sign-in with proper server client ID
        final serverClientId = 'GOOGLE_SERVER_CLIENT_ID';
        print('Server Client ID: $serverClientId');

        await GoogleSignIn.instance.initialize(serverClientId: serverClientId);
        final googleUser = await GoogleSignIn.instance.authenticate();
        if (googleUser == null) {
          return null;
        }
        final googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
        );
        final userCredential = await auth.signInWithCredential(credential);
        return userCredential.user;
      }
    } catch (e) {
      print('Google Sign-In failed: $e');
      return null;
    }
  }

  // Email/Password sign-in
  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('Email/Password Sign-In failed: $e');
      return null;
    }
  }

  // Email/Password registration
  Future<User?> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('Email/Password Registration failed: $e');
      return null;
    }
  }
}

final authServiceProvider = Provider(
  (ref) => GoogleAuthService(auth: FirebaseAuth.instance),
);
