//streams in Flutter in Focus series
//https://www.youtube.com/watch?v=nQBpOIHE4eE

import 'package:flutter/material.dart';
import 'dart:async';

class Demo1 extends StatelessWidget {
  const Demo1 ({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo 1'),
      ),
      body: const MyDemo(),
    );
  }
}

class MyDemo extends StatefulWidget {
  const MyDemo ({Key? key}) : super(key: key);
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
  //this controller allows for any type of data to
  //be added to the streams data events queue.
  StreamController controller = StreamController();
  try {
    //add a data event to the stream of type double
    controller.add(100.0);
    //add a data event to the stream of type list<dynamic>.
    controller.add([10, 20, 30, 'hey there']);
    //add a data event to the stream of type map<string, dynamic>.
    controller.add({'name': 'robbin', 'age': 35});
    //add a data event to the stream of type list<map<string, dynamic>>.
    controller.add([
      {'name': 'joe', 'age': 20},
      {'name': 'sam', 'age': 30}
    ]);
    //add a data event to the stream of type null.
    controller.add(null);
    //add an error event to the stream.
    controller.addError(StateError('This is an error event'));
    //add a data event to the stream of type int.
    controller.add(5);
    //close the controller. Cannot add anything to the stream
    //after closing the controller.
    controller.close();
    //controller.add(10);
  } catch (e) {
    print('catch: $e');
  }

  Stream stream = controller.stream;

  //here we are subscribing to listen to our stream.
  stream.listen((eventData) {
    //this callback is fired every time a new data event
    //is put into the streams queue.
    print('Value of the event: $eventData');
  }, onError: (error) {
    //this onError callback is fired when an error event
    //is added to the stream.
    print('An error event has occured: $error');
  }, onDone: () {
    //this onDone callback is fired when the controller
    //closes the stream.
    print('This stream is done');
  });
}
