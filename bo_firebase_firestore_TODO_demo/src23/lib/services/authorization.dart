// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:robbinlaw/models/user.dart';
import 'package:robbinlaw/services/database.dart';

class Authorization {
  //final auth.FirebaseAuth authInst = auth.FirebaseAuth.instance;
  UserCredential? credential;
  User? myUser;
  User? currentUser = FirebaseAuth.instance.currentUser;

  void listen() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      myUser = user;
      if (user == null) {
        print('Authorization listen; No User is signed in');
      } else {
        print('Authorization listen; id: ${user.uid} email: ${user.email} name: ${user.displayName}');
      }
    });
  }

  Future<bool> createUser(String name, String email, String password) async {
    try {
      print('createUser: currentUser ${FirebaseAuth.instance.currentUser?.displayName}');
      credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: email.trim(), password: password);
      await credential?.user?.updateDisplayName(name);
      print('createUser: currentUser created user ${FirebaseAuth.instance.currentUser?.displayName}');
      print('createUser: credential created user ${credential?.user?.displayName}');
      UserModel userModel = UserModel(
        id: credential?.user!.uid,
        name: credential?.user!.displayName,
        email: credential?.user!.email,
      );
      await Database().createNewUser(userModel);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> logIn(String email, String password) async {
    try {
      print('logIn: currentUser ${FirebaseAuth.instance.currentUser?.displayName}');
      credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email.trim(), password: password);
      print('logIn: currentUser logged in user ${FirebaseAuth.instance.currentUser?.displayName}');
      print('logIn: credential logged in user ${credential?.user?.displayName}');
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> logOut() async {
    try {
      print('logOut: currentUser ${FirebaseAuth.instance.currentUser?.displayName}');
      await FirebaseAuth.instance.signOut();
      print('logOut: currentUser logged out ${FirebaseAuth.instance.currentUser?.displayName}');
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
