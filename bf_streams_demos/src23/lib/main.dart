// ignore_for_file: unused_import, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:robbinlaw/themes/theme.dart';

import 'package:robbinlaw/demos/aa-demo1.dart';
import 'package:robbinlaw/demos/ab-demo2.dart';
import 'package:robbinlaw/demos/ac-demo3.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Color themeColor = const Color(0xFF808366);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: ThemeData.dark(),
      theme: buildTheme(),
      home: Demo1(),
      //home: Demo2(),
      //home: Demo3(),
    );
  }
}
