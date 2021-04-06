import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:robbinlaw/themes/theme.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserCredential _authResult;
  String _email, _password;

  TextEditingController textEditingController1 = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Auth Demo1"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: textEditingController1,
              onChanged: (value) {
                print(value);
              },
              onFieldSubmitted: (text) {
                print('Submitted Email Text = $text');
              },
              validator: (input) {
                return input.contains('@') ? null : 'must include @';
              },
              onSaved: (input) {
                print('onSaved email = $input');
                _email = input;
              },
              cursorColor: colorScheme.onPrimary,
              maxLength: 30,
              decoration: InputDecoration(
                //The border property is what makes a outlined
                //textformfield instead of a filled one.
                border: OutlineInputBorder(),
                icon: Icon(Icons.email),
                labelText: 'email',
                helperText: 'must include @',
                suffixIcon: Icon(
                  Icons.check_circle,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: textEditingController2,
              onChanged: (value) {
                print(value);
              },
              onFieldSubmitted: (text) {
                print('Submitted Password Text = $text');
                setState(() {});
              },
              validator: (input) {
                return input.length < 8 ? 'min 8 chars' : null;
              },
              onSaved: (input) {
                _password = input;
                print('onSaved password = $input');
              },
              //obscureText: true,
              cursorColor: colorScheme.onPrimary,
              maxLength: 20,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                icon: Icon(Icons.emoji_emotions),
                labelText: 'password',
                helperText: 'min 8, max 20',
                suffixIcon: Icon(
                  Icons.check_circle,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              child: Text("Sign Up"),
              onPressed: () {
                _signUp(_email, _password);
              },
            ),
            ElevatedButton(
              child: Text("Log In"),
              onPressed: () {
                _logIn(_email, _password);
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
