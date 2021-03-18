import 'package:flutter/material.dart';

class CustomerOne {
  CustomerOne(this.name, this.age);
  String name;
  int age;

  @override
  String toString() {
    return '{ ${this.name}, ${this.age} }';
  }
}

class CustomerTwo {
  CustomerTwo({this.name, this.age});
  String name;
  int age;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
    };
  }

  @override
  String toString() {
    return '{ ${this.name}, ${this.age} }';
  }
}

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
