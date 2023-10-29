// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart' as firebase;
import 'firebase_options.dart';
import 'package:robbinlaw/themes/theme.dart';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Root(),
      theme: buildTheme(),
    );
  }
}
