//FlutterFire docs
//https://firebase.flutter.dev/docs/overview

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart' as firebase;
import 'package:robbinlaw/dummydata.dart' as dummydata;
import 'package:robbinlaw/firebase_auth_demo1.dart' as firebaseauthdemo1;
import 'package:robbinlaw/firebase_auth_demo2.dart' as firebaseauthdemo2;
import 'package:robbinlaw/firestore_demo1.dart' as firestoredemo1;
import 'package:robbinlaw/firestore_demo2.dart' as firestoredemo2;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebase.Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Demos',
      //home: dummydata.MyHomePage(),
      home: firebaseauthdemo1.MyHomePage(),
      //home: firebaseauthdemo2.MyHomePage(),
      //home: firestoredemo1.MyHomePage(),
      //home: firestoredemo2.MyHomePage(),
    );
  }
}
