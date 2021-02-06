import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart' as firebase;
import 'package:robbinlaw/controllers/globalBindings.dart';
import 'package:robbinlaw/views/root.dart';

//todo app needs work
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebase.Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: GlobalBindings(),
      home: Root(),
      theme: ThemeData.dark(),
    );
  }
}
