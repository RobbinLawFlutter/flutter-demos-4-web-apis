import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserCredential _authResult;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Auth Demo1"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: _emailController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: _passController,
              ),
            ),
            ElevatedButton(
              child: Text("Sign Up"),
              onPressed: () {
                _signUp(_emailController.text, _passController.text);
              },
            ),
            ElevatedButton(
              child: Text("Log In"),
              onPressed: () {
                _logIn(_emailController.text, _passController.text);
              },
            ),
            ElevatedButton(
              child: Text("Log Out"),
              onPressed: () {
                _logOut();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _signUp(String email, String password) async {
    try {
      _authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print('user credential: ${_authResult.credential}');
      print('user id: ${_authResult.user.uid}');
      print('user email: ${_authResult.user.email}');
      print('email has been verified: ${_authResult.user.emailVerified}');
      print('login is anonymous: ${_authResult.user.isAnonymous}');
      Get.snackbar(
        "signup",
        "successful",
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 5),
      );
    } catch (e) {
      Get.snackbar(
        "signup ERROR",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 5),
      );
    }
  }

  void _logIn(String email, String password) async {
    try {
      _authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print('user credential: ${_authResult.credential}');
      print('user id: ${_authResult.user.uid}');
      print('user email: ${_authResult.user.email}');
      print('email has been verified: ${_authResult.user.emailVerified}');
      print('login is anonymous: ${_authResult.user.isAnonymous}');
      Get.snackbar(
        "login SUCCESSFUL",
        'user email: ${_authResult.user.email}',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 5),
      );
    } catch (e) {
      Get.snackbar(
        "login ERROR",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 5),
      );
    }
  }

  void _logOut() async {
    try {
      await _auth.signOut();
      Get.snackbar(
        "logOut SUCCESSFUL",
        'user email: ${_authResult.user.email}',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 5),
      );
    } catch (e) {
      Get.snackbar(
        "logOut ERROR",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
