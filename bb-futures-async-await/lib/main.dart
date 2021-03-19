//Isolates and the Event Loop from Google Flutter in Focus series 5min.
//https://www.youtube.com/watch?v=vl_AaCgudcY&list=PLjxrf2q8roU2HdJQDjJzOeO6J3FoFLWr2&index=14

//Futures from Google Flutter in Focus series 8min.
//https://www.youtube.com/watch?v=OTS-ap9_aXc&list=PLjxrf2q8roU2HdJQDjJzOeO6J3FoFLWr2&index=15

//Async Await from Google Flutter in Focus series 8min.
//https://www.youtube.com/watch?v=SmTCmDMi4BY&list=PLjxrf2q8roU2HdJQDjJzOeO6J3FoFLWr2&index=17

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:robbinlaw/demos/aa-demo1.dart';
import 'package:robbinlaw/demos/ab-demo2.dart';
import 'package:robbinlaw/demos/ac-demo3.dart';
import 'package:robbinlaw/demos/ad-demo4.dart';

import 'package:robbinlaw/views/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      //home: Demo1(),
      home: Demo2(),
      //home: Demo3(),
      //home: Demo4(),
      //home: HomeView(),
    );
  }
}
