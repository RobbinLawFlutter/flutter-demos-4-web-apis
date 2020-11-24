//Isolates and the Event Loop from Google Flutter in Focus series
//https://www.youtube.com/watch?v=vl_AaCgudcY&list=PLjxrf2q8roU2HdJQDjJzOeO6J3FoFLWr2&index=14

//Futures from Google Flutter in Focus series 8min.
//https://www.youtube.com/watch?v=OTS-ap9_aXc&list=PLjxrf2q8roU2HdJQDjJzOeO6J3FoFLWr2&index=15

//Async Await from Google Flutter in Focus series 8min.
//https://www.youtube.com/watch?v=SmTCmDMi4BY&list=PLjxrf2q8roU2HdJQDjJzOeO6J3FoFLWr2&index=17

import 'package:flutter/material.dart';

import 'demos/aa_demo1.dart';
import 'demos/ab_demo2.dart';
import 'demos/ac_demo3.dart';
import 'demos/ad_demo4.dart';

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

      // home: Demo1(
      //   title: 'Demo 1',
      // ),

      home: Demo2(
        title: 'Demo 2',
      ),

      // home: Demo3(
      //   title: 'Demo 3',
      // ),

      // home: Demo4(
      //   title: 'Demo 4',
      // ),
    );
  }
}
