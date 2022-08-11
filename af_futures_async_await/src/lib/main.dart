//Isolates and the Event Loop from Google Flutter in Focus series 5min.
//https://www.youtube.com/watch?v=vl_AaCgudcY&list=PLjxrf2q8roU2HdJQDjJzOeO6J3FoFLWr2&index=14

//Futures from Google Flutter in Focus series 8min.
//https://www.youtube.com/watch?v=OTS-ap9_aXc&list=PLjxrf2q8roU2HdJQDjJzOeO6J3FoFLWr2&index=15

//Async Await from Google Flutter in Focus series 8min.
//https://www.youtube.com/watch?v=SmTCmDMi4BY&list=PLjxrf2q8roU2HdJQDjJzOeO6J3FoFLWr2&index=17

//FutureBuilder Widget of the Week 2min.
//https://www.youtube.com/watch?v=ek8ZPdWj4Qo

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
      home: const Demo1(),
      //home: const Demo2(),
    );
  }
}
