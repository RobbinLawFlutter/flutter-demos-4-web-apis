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
      child: RaisedButton(
        child: Text('Press'),
        onPressed: () {
          performTasks();
        },
      ),
    );
  }
}

void performTasks() async {
  task1();
  String task2Result = await task2c();
  task3a(task2Result);
}

void task1() {
  print('Task 1 start');
  String result = 'task 1 data';
  print('Task 1 complete');
}

Future<String> task2c() async {
  print('Task 2 start');
  String result;
  Duration myFiveSeconds = Duration(seconds: 5);
  //async method that will delay for 5 seconds,
  //and then run the callback method, which is
  //the second parm.
  //Using await will cause this to now act synchronously.
  await Future.delayed(myFiveSeconds, () {
    result = 'task 2 data';
    print('Task 2 complete');
  });
  return result;
}

void task3a(String taskTwoData) {
  print('Task 3 start');
  String result = 'task 3 data';
  print('Task 3 complete with $taskTwoData');
}
