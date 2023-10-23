//https://firebase.flutter.dev/docs/auth/usage/

// ignore_for_file: avoid_print, use_key_in_widget_constructors

import 'package:flutter/material.dart';
//import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late UserCredential _authResult;
  String _email = "", _password = "";
  bool isUserLoggedIn = false;

  final formKey = GlobalKey<FormState>();
  TextEditingController textEditingController1 = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        isUserLoggedIn = false;
        print('User is currently signed out!');
      } else {
        isUserLoggedIn = true;
        print('User is signed in as: ${_auth.currentUser!.email}');
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase Auth Demo1"),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: textEditingController1,
                onChanged: (value) {
                  //print(value);
                },
                onFieldSubmitted: (text) {
                  if (formKey.currentState!.validate()) {}
                  print('Submitted Email Text = $text');
                },
                validator: (input) {
                  return input!.contains('@') ? null : 'hey it must include @';
                },
                onSaved: (input) {
                  print('onSaved email = $input');
                  _email = input.toString();
                },
                //cursorColor: colorScheme.onPrimary,
                maxLength: 30,
                decoration: const InputDecoration(
                  //The border property is what makes a outlined
                  //textformfield instead of a filled one.
                  border: OutlineInputBorder(),
                  icon: Icon(
                    Icons.email,
                    //color: colorScheme.onBackground,
                  ),
                  labelText: 'email',
                  helperText: 'must include @',
                  suffixIcon: Icon(
                    Icons.check_circle,
                    //color: colorScheme.onPrimary,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: textEditingController2,
                onChanged: (value) {
                  //print(value);
                },
                onFieldSubmitted: (text) {
                  if (formKey.currentState!.validate()) {}
                  //print('Submitted Password Text = $text');
                },
                validator: (input) {
                  return input!.length < 6 ? 'min 6 chars' : null;
                },
                onSaved: (input) {
                  _password = input.toString();
                  print('onSaved password = $input');
                },
                //obscureText: true,
                //cursorColor: colorScheme.onPrimary,
                maxLength: 20,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  icon: Icon(
                    Icons.emoji_emotions,
                    //color: colorScheme.onBackground,
                  ),
                  labelText: 'password',
                  helperText: 'min 6, max 20',
                  suffixIcon: Icon(
                    Icons.check_circle,
                    //color: colorScheme.onPrimary,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: const Text("Sign Up"),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        //textEditingController1.clear();
                        //textEditingController2.clear();
                        setState(() {});
                      }
                      _signUp(_email, _password);
                      //_email = '';
                      //_password = '';
                    },
                  ),
                  ElevatedButton(
                    child: const Text("Log In"),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        //textEditingController1.clear();
                        //textEditingController2.clear();
                        setState(() {});
                      }
                      _logIn(_email, _password);
                      //_email = '';
                      //_password = '';
                    },
                  ),
                  ElevatedButton(
                    child: const Text("Log Out"),
                    onPressed: () {
                      _logOut();
                      _email = '';
                      _password = '';
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signUp(String email, String password) async {
    try {
      _authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      //print('user credential: ${_authResult.credential}');
      //print('user id: ${_authResult.user.uid}');
      //print('user email: ${_authResult.user.email}');
      //print('email has been verified: ${_authResult.user.emailVerified}');
      //print('login is anonymous: ${_authResult.user.isAnonymous}');
      // Get.snackbar(
      //   "signup successful",
      //   'user email: ${_authResult.user!.email}',
      //   snackPosition: SnackPosition.BOTTOM,
      //   duration: const Duration(seconds: 5),
      // );
    } catch (e) {
      // Get.snackbar(
      //   "signup ERROR",
      //   e.toString(),
      //   snackPosition: SnackPosition.BOTTOM,
      //   duration: const Duration(seconds: 5),
      // );
    }
  }

  void _logIn(String email, String password) async {
    try {
      _authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      // Get.snackbar(
      //   "login SUCCESSFUL",
      //   'user email: ${_authResult.user!.email}',
      //   snackPosition: SnackPosition.BOTTOM,
      //   duration: const Duration(seconds: 5),
      // );
    } catch (e) {
      // Get.snackbar(
      //   "login ERROR",
      //   e.toString(),
      //   snackPosition: SnackPosition.BOTTOM,
      //   duration: const Duration(seconds: 5),
      // );
    }
  }

  void _logOut() async {
    try {
      await _auth.signOut();
      //_authResult = null;
      // Get.snackbar(
      //   "logOut SUCCESSFUL",
      //   'user email: ${_authResult.user!.email}',
      //   snackPosition: SnackPosition.BOTTOM,
      //   duration: const Duration(seconds: 5),
      // );
    } catch (e) {
      // Get.snackbar(
      //   "logOut ERROR",
      //   e.toString(),
      //   snackPosition: SnackPosition.BOTTOM,
      // );
    }
  }
}
