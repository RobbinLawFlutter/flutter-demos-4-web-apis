// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

import 'package:robbinlaw/demos/demo1.dart';

//ListView Widget of the Week
//https://www.youtube.com/watch?v=KJpkjHGiI5A&vl=en

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
    );
  }
}
