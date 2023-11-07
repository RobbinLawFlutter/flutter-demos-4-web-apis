// ignore_for_file: avoid_print, use_key_in_widget_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

//https://firebase.google.com/docs/auth/flutter/start

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final FirebaseAuth authInst = FirebaseAuth.instance;
  late UserCredential credential;
  String email = "", password = "";
  bool isUserLoggedIn = false;

  final formKey = GlobalKey<FormState>();
  TextEditingController textEditingController1 = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print('build started');
    authInst.authStateChanges().listen((User? user) {
      if (user == null) {
        isUserLoggedIn = false;
        print('User is currently signed out!');
      } else {
        isUserLoggedIn = true;
        print('user id: ${authInst.currentUser!.uid}');
        print('user email: ${authInst.currentUser!.email}');
        print('email has been verified: ${authInst.currentUser!.emailVerified}');
        print('login is anonymous: ${authInst.currentUser!.isAnonymous}');
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
                  email = input.toString();
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
                  password = input.toString();
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
                      signUp(email, password);
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
                        logIn(email, password);
                        
                        //_email = '';
                        //_password = '';
                    },
                  ),
                  ElevatedButton(
                    child: const Text("Log Out"),
                    onPressed: () {
                      logOut();
                      //_email = '';
                      //_password = '';
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

  void signUp(String email, String password) async {
    try {
      credential = await authInst.createUserWithEmailAndPassword(
          email: email, password: password);
      dynamic snackBar = mySnackBar('signup success');
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      print(e.toString());
      dynamic snackBar = mySnackBar('signup failed');
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

   void logIn(email, String password) async {
    try {
      credential = await authInst.signInWithEmailAndPassword(
          email: email, password: password);
      dynamic snackBar = mySnackBar('login success');
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      print(e.toString());
      dynamic snackBar = mySnackBar('login failed');
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void logOut() async {
    try {
      await authInst.signOut();
      dynamic snackBar = mySnackBar('logout success');
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      //_authResult = null;
    } catch (e) {
      print(e.toString());
      dynamic snackBar = mySnackBar('logout failed');
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  SnackBar mySnackBar(String text) {
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Row(
        children: [
          const Icon(Icons.accessibility_new_rounded),
          const SizedBox(
            width: 10,
          ),
          Text(text),
        ],
      ),
      action: SnackBarAction(
        label: 'Click Me',
        onPressed: () {
          print('hey you clicked on the snackbar Action');
        },
      ),
    );
  }
}
