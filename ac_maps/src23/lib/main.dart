// ignore_for_file: use_key_in_widget_constructors, unused_import

import 'package:flutter/material.dart';

import 'package:robbinlaw/demos/demo1.dart';
import 'package:robbinlaw/demos/demo2.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Demo1(),
      // Demo2 is extra and advanced.
      //home: Demo2(),
    );
  }
}
