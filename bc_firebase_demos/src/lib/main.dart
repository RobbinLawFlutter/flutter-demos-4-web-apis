//FlutterFire docs
//https://firebase.flutter.dev/docs/overview

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart' as firebase;
import 'firebase_options.dart';
import 'package:robbinlaw/themes/theme.dart';

import 'package:robbinlaw/dummydata.dart' as dummydata;
import 'package:robbinlaw/firestore_demo1.dart' as firestoredemo1;

import 'package:robbinlaw/firebase_auth_demo1.dart' as firebaseauthdemo1;


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebase.Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp ({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: ThemeData.dark(),
      theme: buildTheme(),
      //home: dummydata.MyHomePage(),
      //home: firestoredemo1.MyHomePage(),
      //home: firestoredemo2.MyHomePage(),
      home: firebaseauthdemo1.MyHomePage(),
    );
  }
}
