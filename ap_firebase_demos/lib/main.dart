//FlutterFire docs
//https://firebase.flutter.dev/docs/overview

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart' as firebase;
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:ap_firebase_demos/dummydata.dart' as dummydata;
import 'package:ap_firebase_demos/firebasedemo.dart' as firebasedemo;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebase.Firebase.initializeApp();
  runApp(MyApp());
}

// class App extends StatelessWidget {
//   // Create the initialization Future outside of `build`:
//   final Future<firebase.FirebaseApp> _initialization =
//       firebase.Firebase.initializeApp();

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       // Initialize FlutterFire:
//       future: _initialization,
//       builder: (context, snapshot) {
//         // Check for errors
//         if (snapshot.hasError) {
//           return SomethingWentWrong();
//         }

//         // Once complete, show your application
//         if (snapshot.connectionState == ConnectionState.done) {
//           return MyApp();
//         }

//         // Otherwise, show something whilst waiting for initialization to complete
//         return Loading();
//       },
//     );
//   }
// }

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

class SomethingWentWrong extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Text(
        'opps',
        textDirection: TextDirection.ltr,
      )),
    );
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Text(
        'opps',
        textDirection: TextDirection.ltr,
      )),
    );
  }
}
