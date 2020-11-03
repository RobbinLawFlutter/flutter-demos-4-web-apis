import 'package:flutter/material.dart';


class Demo3 extends StatelessWidget {
  MyDemo1({this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: MyDemo(),
      ),
  }
}

class MyDemo extends StatefulWidget {
  
  @override
  _MyDemoState createState() => _MyDemoState();
}

class _MyDemoState extends State<MyDemo> {
  @override
  Widget build(BuildContext context) {
    
  }
}
