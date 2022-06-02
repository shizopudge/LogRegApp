import 'package:firebase_auth/firebase_auth.dart';

class appUser {
  String? id;

  appUser.fromFirebase(User? user) {
    id = user!.uid;
  }
}
