import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:robbinlaw/demos/demo1.dart';
import 'package:robbinlaw/demos/demo2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp ({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      //home: const Demo1(),
      home: const Demo2(),
    );
  }
}
