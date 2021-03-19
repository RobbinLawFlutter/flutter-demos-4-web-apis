import 'package:flutter/material.dart';
import 'dart:io';

class Demo1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo1'),
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
      child: RaisedButton(
        child: Text('Press'),
        onPressed: () {
          performTasks();
        },
      ),
    );
  }
}

void performTasks() {
  //task1();
  //task2();
  //task2a();
  //task2b();
  //String task2Result = task2c();
  //task3();
  //task3a(task2Result);
}

void task1() {
  print('Task 1 start');
  String result = 'task 1 data';
  print('Task 1 complete');
}

void task2() {
  print('Task 2 start');
  String result = 'task 2 data';
  print('Task 2 complete');
}

//In this method the sleep method runs synchronously.
void task2a() {
  print('Task 2a start');
  Duration myThreeSeconds = Duration(seconds: 3);
  //We can access sleep() by importing dart.io.
  sleep(myThreeSeconds);

  String result = 'task 2a data';
  print('Task 2a complete');
}

//In this method the Future.delayed method runs asynchronously.
void task2b() {
  print('Task 2b start');
  Duration myFiveSeconds = Duration(seconds: 5);
  //async method that will delay for 5 seconds,
  //and then run the callback method, which is
  //the second parm.
  Future.delayed(myFiveSeconds, () {
    String result = 'task 2b data';
    print('Task 2b complete');
  });
  print('Task 2b waiting for 5 seconds');
}

String task2c() {
  print('Task 2c start');
  String result;
  Duration myFiveSeconds = Duration(seconds: 5);
  //async method that will delay for 5 seconds,
  //and then run the callback method, which is
  //the second parm.
  Future.delayed(myFiveSeconds, () {
    result = 'task 2c data';
    print('Task 2c complete');
  });
  return result;
}

void task3() {
  print('Task 3 start');
  String result = 'task 3 data';
  print('Task 3 complete');
}

void task3a(String taskTwoData) {
  print('Task 3a start');
  String result = 'task 3a data';
  print('Task 3a complete with $taskTwoData');
}
