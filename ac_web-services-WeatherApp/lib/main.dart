import 'package:flutter/material.dart';
import 'package:clima/screens/loading_screen1.dart';
import 'package:clima/screens/loading_screen2.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: LoadingScreen1(),
      //home: LoadingScreen2(),
    );
  }
}
