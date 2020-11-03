import 'package:flutter/material.dart';

import 'package:async_await/demos/aa_demo1.dart';
import 'package:async_await/demos/ab_demo2.dart';
import 'package:async_await/demos/ac_demo3.dart';
import 'package:async_await/demos/ad_demo4.dart';

void main() => runApp(
      MyDemos(),
    );

class MyDemos extends StatelessWidget {
  final Color themeColor = Color(0xFF808366);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tabbed with Scoped Model Demos',
      theme: ThemeData.light().copyWith(
        brightness: Brightness.light,
        accentColor: Colors.cyan[600],
        primaryColor: themeColor,
        scaffoldBackgroundColor: themeColor,
        indicatorColor: Colors.white,
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Colors.white,
            fontSize: 36,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
          size: 200,
        ),
        primaryIconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),

      home: Demo1(
        title: 'Demo 1',
      ),

      // home: Demo2(
      //   title: 'Demo 2',
      // ),

      // home: Demo3(
      //   title: 'Demo 3',
      // ),

      // home: Demo4(
      //   title: 'Demo 4',
      // ),
    );
  }
}
