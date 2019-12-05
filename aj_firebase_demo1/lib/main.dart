import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:aj_firebase_demo1/dummydata.dart' as dummydata;
import 'package:aj_firebase_demo1/firebasedemo.dart' as firebasedemo;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Baby Names',
      home: firebasedemo.MyHomePage(),
    );
  }
}
