// ignore_for_file: use_key_in_widget_constructors, unused_import

import 'package:flutter/material.dart';
//import 'package:get/get.dart';

import 'package:robbinlaw/views/loading-view1.dart';
import 'package:robbinlaw/views/loading-view2.dart';

//VERY IMPORTANT!!!
//To add the geolocator to your Flutter application
//read the install instructions in
//the "docs" folder of this project.
//In there, are some Android and iOS specifics
//that are required for the geolocator to work correctly.

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      //home: const LoadingView1(),
      home: const LoadingView2(),
    );
  }
}