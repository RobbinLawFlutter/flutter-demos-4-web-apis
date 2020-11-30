//streams in Flutter in Focus series
//https://www.youtube.com/watch?v=nQBpOIHE4eE

import 'package:flutter/material.dart';
import 'dart:async';

class Demo1 extends StatelessWidget {
  Demo1({this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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
      child: TextButton(
        child: Text('Press'),
        onPressed: () {
          performTasks();
        },
      ),
    );
  }
}

void performTasks() {
  final controller = StreamController();
  controller.sink.add(100.0);
  controller.sink.add([10, 20, 30, 'hey there']);
  controller.sink.add({'name': 'robbin', 'age': 35});
  controller.sink.add([
    {'name': 'joe', 'age': 20},
    {'name': 'sam', 'age': 30}
  ]);
  controller.sink.add(null);
  controller.sink.addError(StateError('Hey man this is an error'));
  controller.sink.add(5);
  controller.close();

  controller.stream.listen((event) {
    print(event);
  }, onError: (error) {
    print(error);
  }, onDone: () {
    print('Hey Man this stream is done');
  });
  task1();
  //task2();
  //task3();
  //task4();
}

void task1() {}
