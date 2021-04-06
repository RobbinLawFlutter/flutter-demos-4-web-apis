import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:robbinlaw/themes/theme.dart';

import 'package:robbinlaw/demos/aa-demo1.dart';
import 'package:robbinlaw/demos/ab-demo2.dart';
import 'package:robbinlaw/demos/ac-demo3.dart';
import 'package:robbinlaw/demos/ad-demo4.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Color themeColor = Color(0xFF808366);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: ThemeData.dark(),
      theme: buildTheme(),
      //home: Demo1(),
      //home: Demo2(),
      home: Demo3(),
      //home: Demo4(),
    );
  }
}
