//FlutterFire docs
//https://firebase.flutter.dev/docs/overview

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart' as firebase;
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:ap_firebase_demos/dummydata.dart' as dummydata;
import 'package:ap_firebase_demos/firebasedemo.dart' as firebasedemo;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebase.Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Baby Names',
      //home: dummydata.MyHomePage(),
      home: firebasedemo.MyHomePage(),
    );
  }
}
