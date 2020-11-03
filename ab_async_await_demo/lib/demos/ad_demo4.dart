import 'package:flutter/material.dart';

class Demo4 extends StatelessWidget {
  Demo4({this.title});

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
      child: RaisedButton(
        child: Text('Press'),
        onPressed: () {
          performTasks();
        },
      ),
    );
  }

  void performTasks() async {
    task1();
    //task2();
    //task2a();
    //task2b();
    String task2Result = await task2c();
    //task3();
    task3a(task2Result);
  }

  void task1() {
    String result = 'task 1 data';
    print('Task 1 complete');
  }

  void task2() {
    String result = 'task 2 data';
    print('Task 2 complete');
  }

  void task2b() {
    Duration myThreeSeconds = Duration(seconds: 3);
    //async method that will delay for 3 seconds,
    //and then run the callback method, which is
    //the second parm.
    Future.delayed(myThreeSeconds, () {
      String result = 'task 2 data';
      print('Task 2 complete');
    });
  }

  Future<String> task2c() async {
    String result;
    Duration myThreeSeconds = Duration(seconds: 3);
    //async method that will delay for 3 seconds,
    //and then run the callback method, which is
    //the second parm.
    await Future.delayed(myThreeSeconds, () {
      result = 'task 2 data';
      print('Task 2 complete');
    });
    return result;
  }

  void task3() {
    String result = 'task 3 data';
    print('Task 3 complete');
  }

  void task3a(String taskTwoData) {
    String result = 'task 3 data';
    print('Task 3 complete with $taskTwoData');
  }
}
