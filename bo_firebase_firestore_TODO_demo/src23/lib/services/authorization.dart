// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:robbinlaw/models/user.dart';
import 'package:robbinlaw/services/database.dart';

class Auth {
  User? currentUser = FirebaseAuth.instance.currentUser;

  void listen() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('Auth listen; No User');
      } else {
        print('Auth listen: email= ${user.email} name= ${user.displayName}');
      }
    });
  }

  Future<bool> createUser(String name, String email, String password) async {
    try {
      print('Auth createUser: TRY');
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: email.trim(), password: password);
      await credential.user?.updateDisplayName(name);
      UserModel userModel = UserModel(
        id: FirebaseAuth.instance.currentUser?.uid,
        name: FirebaseAuth.instance.currentUser?.displayName,
        email: FirebaseAuth.instance.currentUser?.email,
      );
      await Database().createNewUser(userModel);
      return true;
    } catch (e) {
      print('Auth createUser: CATCH $e');
      return false;
    }
  }

  Future<bool> logIn(String email, String password) async {
    try {
      print('Auth logIn: TRY');
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email.trim(), password: password);
      return true;
    } catch (e) {
      print('Auth logIn: CATCH $e');
      return false;
    }
  }

  Future<bool> logOut() async {
    try {
      print('Auth logOut: try');
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (e) {
      print('Auth logOut: CATCH $e');
      return false;
    }
  }
}
