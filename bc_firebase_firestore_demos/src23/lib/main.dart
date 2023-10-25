// ignore_for_file: use_key_in_widget_constructors, library_prefixes, unused_import

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart' as firebase;
import 'firebase_options.dart';
import 'package:robbinlaw/themes/theme.dart';
import 'package:robbinlaw/dummydata.dart' as dummydata;
import 'package:robbinlaw/firestore_demo1.dart' as firestoredemo1;
import 'package:robbinlaw/firestore_demo2.dart' as firestoredemo2;
import 'package:robbinlaw/firebase_auth_demo1.dart' as firebaseauthdemo1;

//FlutterFire docs
//https://firebase.google.com/docs/flutter/setup?platform=android

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebase.Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      //home: dummydata.MyHomePage(),
      //home: firestoredemo1.MyHomePage(),
      home: firestoredemo2.MyHomePage(),
      //home: firebaseauthdemo1.MyHomePage(),
    );
  }
}
