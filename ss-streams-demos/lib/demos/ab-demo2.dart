import 'package:flutter/material.dart';

class Demo2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo2'),
      ),
      body: MyDemo(),
    );
  }
}

class MyDemo extends StatefulWidget {
  @override
  _MyDemoState createState() => _MyDemoState();
}

class _MyDemoState extends State<MyDemo> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text('Press'),
        onPressed: () {
          performTasks();
        },
      ),
    );
  }
}

void performTasks() {}
