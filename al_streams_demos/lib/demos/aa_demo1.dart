//streams in Flutter in Focus series
//https://www.youtube.com/watch?v=nQBpOIHE4eE

import 'package:flutter/material.dart';
import 'dart:async';

class Demo1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo 1'),
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
  controller.add(100.0);
  controller.add([10, 20, 30, 'hey there']);
  controller.add({'name': 'robbin', 'age': 35});
  controller.add([
    {'name': 'joe', 'age': 20},
    {'name': 'sam', 'age': 30}
  ]);
  controller.add(null);
  controller.addError(StateError('Hey man this is an error'));
  controller.add(5);
  controller.close();
  //controller.add(10);

  controller.stream.listen((event) {
    print(event);
  }, onError: (error) {
    print(error);
  }, onDone: () {
    print('Hey Man this stream is done');
  });
}
