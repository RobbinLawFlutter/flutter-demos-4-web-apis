// ignore_for_file: use_key_in_widget_constructors, unused_import

import 'package:flutter/material.dart';

import 'package:robbinlaw/demos/demo1.dart';

//Isolates and the Event Loop from Google Flutter in Focus series 5min.
//https://www.youtube.com/watch?v=vl_AaCgudcY&list=PLjxrf2q8roU2HdJQDjJzOeO6J3FoFLWr2&index=14

//Futures from Google Flutter in Focus series 8min.
//https://www.youtube.com/watch?v=OTS-ap9_aXc&list=PLjxrf2q8roU2HdJQDjJzOeO6J3FoFLWr2&index=15

//Async Await from Google Flutter in Focus series 8min.
//https://www.youtube.com/watch?v=SmTCmDMi4BY&list=PLjxrf2q8roU2HdJQDjJzOeO6J3FoFLWr2&index=17

//FutureBuilder Widget of the Week 2min.
//https://www.youtube.com/watch?v=ek8ZPdWj4Qo

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Demo1(),
    );
  }
}
