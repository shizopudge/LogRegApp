// ignore_for_file: unused_catch_clause

import 'package:firebase_auth/firebase_auth.dart';
import 'package:logregapp/appUser.dart';

class AuthService {
  final FirebaseAuth _fAuth = FirebaseAuth.instance;

  Future<appUser?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _fAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return appUser.fromFirebase(user);
    } on FirebaseException catch (error) {
      return null;
    }
  }

  Future<appUser?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _fAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return appUser.fromFirebase(user);
    } on FirebaseException catch (error) {
      return null;
    }
  }

  Future logOut() async {
    await _fAuth.signOut();
  }

  Stream<appUser?> get currentUser {
    return _fAuth
        .authStateChanges()
        .map((User? user) => user != null ? appUser.fromFirebase(user) : null);
  }
}
