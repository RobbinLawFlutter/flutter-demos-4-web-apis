//Isolates (single threaded non blocking process with an event loop),
//Futures (Promises in JavaScript; container with 3 states:
//non-completed, completed with data, completed with error),
//Streams (data and error events that firebase sends via a socket to our event queue),
//async/await articles from medium
//https://medium.com/dartlang/dart-asynchronous-programming-isolates-and-event-loops-bffc3e296a6a

//Firestore by the flutter in focus series
//https://www.youtube.com/watch?v=DqJ_KjFzL9I&list=PLjxrf2q8roU2HdJQDjJzOeO6J3FoFLWr2&index=9

//getx (navigation manager and state manager) documentation from medium
//https://medium.com/flutter-community/the-flutter-getx-ecosystem-dependency-injection-8e763d0ec6b9

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart' as firebase;
import 'firebase_options.dart';
import 'package:robbinlaw/bindings/globalBindings.dart';
import 'package:robbinlaw/views/root.dart';

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
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      //dependance injection via Bindings().
      initialBinding: GlobalBindings(),
      home: Root(),
      theme: ThemeData.dark(),
    );
  }
}
