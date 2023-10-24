//VERY IMPORTANT!!!
//To add the geolocator to your Flutter application
//read the install instructions in
//the "docs" folder of this project.
//In there, are some Android and iOS specifics
//that are required for the geolocator to work correctly.

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:robbinlaw/views/loading-view1.dart';
import 'package:robbinlaw/views/loading-view2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      //home: const LoadingView1(),
      home: const LoadingView2(),
    );
  }
}
