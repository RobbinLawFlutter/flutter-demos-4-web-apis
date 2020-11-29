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
        accentColor: Colors.black,
        primaryColor: themeColor,
        primaryTextTheme: TextTheme(),
        scaffoldBackgroundColor: themeColor,
        cursorColor: Colors.black,
        dialogTheme: DialogTheme(
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
            color: themeColor,
            fontSize: 25,
          ),
        ),
        //inputDecorationTheme applies to TextField Widget.
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: themeColor,
          hintStyle: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        indicatorColor: Colors.black,
        textTheme: TextTheme(
          //subtitle1 is for ListTile text color,
          //and the TextField edited text color.
          subtitle1: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              foregroundColor: MaterialStateProperty.all(themeColor),
              textStyle: MaterialStateProperty.all(
                TextStyle(
                  fontSize: 20,
                ),
              )),
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
