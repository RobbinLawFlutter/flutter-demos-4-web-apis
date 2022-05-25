import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:robbinlaw/themes/theme.dart';

import 'package:robbinlaw/views/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp ({Key? key}) : super(key: key);
  final Color themeColor = Color(0xFF808366);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: ThemeData.dark(),
      theme: buildTheme(),
      home: HomeView(),
    );
  }
}
