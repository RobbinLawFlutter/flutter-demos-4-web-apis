import 'package:flutter/material.dart';
import 'dart:io';

class Demo1 extends StatelessWidget {
  const Demo1 ({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo1'),
      ),
      body: const MyDemo(),
    );
  }
}

class MyDemo extends StatefulWidget {
  const MyDemo({Key? key}) : super(key: key);
  @override
  MyDemoState createState() => MyDemoState();
}

class MyDemoState extends State<MyDemo> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text('Press'),
        onPressed: () {
          performTasks();
        },
      ),
    );
  }
}

void performTasks() {
  
}
