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
        title: Text("Firebase Auth Demo2"),
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
            RaisedButton(
              child: Text("Sign Up"),
              onPressed: () {
                _signUp(_emailController.text, _passController.text);
              },
            ),
            RaisedButton(
              child: Text("Log In"),
              onPressed: () {
                _logIn(_emailController.text, _passController.text);
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
      print("Account created for user: " + _authResult.user.email);
      _authResult.user.sendEmailVerification();
    } catch (e) {
      print(e);
    }
  }

  void _logIn(String email, String password) async {
    try {
      _authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (_authResult.user.emailVerified) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SignedIn(),
          ),
        );
      } else {
        print("YOU NEED TO VERIFY EMAIL");
      }
    } catch (e) {
      print(e);
    }
  }
}

class SignedIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Signed In"),
      ),
    );
  }
}
