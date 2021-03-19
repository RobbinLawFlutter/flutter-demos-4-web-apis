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
          //performTasks1();
          //performTasks2();
          performTasks3();
        },
      ),
    );
  }
}

void performTasks1() {
  task1();
  task2();
}

void performTasks2() {
  String task3Result = task3();
  task4(task3Result);
}

void performTasks3() async {
  String task5Result = await task5();
  task6(task5Result);
}

//In this method the sleep method runs synchronously.
void task1() {
  print('Task 1 start');
  Duration myFiveSeconds = Duration(seconds: 5);
  //We can access sleep() by importing dart.io.
  sleep(myFiveSeconds);
  print('Task 1 end');
}

//In this method the Future.delayed method runs asynchronously.
void task2() {
  print('Task 2 start');
  Duration myFiveSeconds = Duration(seconds: 5);
  //async method that will delay for 5 seconds,
  //and then run the callback method, which is
  //the second parm.
  Future.delayed(myFiveSeconds, () {
    print('Task 2 future callback complete');
  });
  print('Task 2 end');
}

//In this method the Future.delayed method runs asynchronously.
String task3() {
  print('Task 3 start');
  String result;
  Duration myFiveSeconds = Duration(seconds: 5);
  //async method that will delay for 5 seconds,
  //and then run the callback method, which is
  //the second parm.
  Future.delayed(myFiveSeconds, () {
    result = 'task 3 data';
    print('Task 3 future callback complete');
  });
  print('Task 3 end');
  return result;
}

void task4(String data) {
  print('Task 4 start');
  print('Task 4 end with $data');
}

//In this method the Future.delayed method runs synchronously.
Future<String> task5() async {
  print('Task 5 start');
  String result;
  Duration myFiveSeconds = Duration(seconds: 5);
  //async method that will delay for 5 seconds,
  //and then run the callback method, which is
  //the second parm.
  //Using await will cause this to now act synchronously.
  await Future.delayed(myFiveSeconds, () {
    result = 'task 5 data';
    print('Task 5 future callback complete');
  });
  print('Task 5 end');
  return result;
}

void task6(String data) {
  print('Task 6 start');
  print('Task 6 end with $data');
}
