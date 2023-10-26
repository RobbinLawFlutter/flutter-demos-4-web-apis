// ignore_for_file: unused_import

import 'package:flutter/material.dart';
//import 'package:get/get.dart';
import 'package:robbinlaw/themes/theme.dart';

import 'package:robbinlaw/demos/aa-demo1.dart';
import 'package:robbinlaw/demos/ab-demo2.dart';
import 'package:robbinlaw/demos/ac-demo3.dart';

//streams from flutter in focus series.
//https://www.youtube.com/watch?v=nQBpOIHE4eE

//streambuilder widget of the week.
//https://www.youtube.com/watch?v=MkKEWHfy99Y

//stream basics by medium
//https://medium.com/flutter-community/flutter-stream-basics-for-beginners-eda23e44e32f

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp ({Key? key}) : super(key: key);
  final Color themeColor = const Color(0xFF808366);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: ThemeData.dark(),
      theme: buildTheme(),
      //home: const Demo1(),
      //home: const Demo2(),
      home: Demo3(),
    );
  }
}
