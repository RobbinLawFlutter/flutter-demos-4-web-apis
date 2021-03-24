import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:robbinlaw/views/loading-view1.dart';
import 'package:robbinlaw/views/loading-view2.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: LoadingView1(),
      //home: LoadingView2(),
    );
  }
}
