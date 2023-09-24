//VERY IMPORTANT!!!
//To add the geolocator to your Flutter application
//read the install instructions in
//the "docs" folder of this project.
//In there, are some Android and iOS specifics
//that are required for the geolocator to work correctly.

// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
//import 'package:get/get.dart';

import 'package:robbinlaw/views/loading-view1.dart';
import 'package:robbinlaw/views/loading-view2.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const LoadingView1(),
      //home: const LoadingView2(),
    );
  }
}
