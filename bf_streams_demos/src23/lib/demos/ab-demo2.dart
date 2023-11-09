// ignore_for_file: file_names, use_key_in_widget_constructors, unused_local_variable, avoid_print

import 'package:flutter/material.dart';
import 'dart:async';

class Demo2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo 2'),
      ),
      body: MyDemo(),
    );
  }
}

class MyDemo extends StatefulWidget {
  @override
  MyDemoState createState() => MyDemoState();
}

class MyDemoState extends State<MyDemo> {
  Timer? timer;
  Duration interval = const Duration(seconds: 2);
  int maxCount = 10;
  int counter = 0;

  StreamController<int> controller = StreamController<int>(
    onListen: () {
      print('StreamController onListen');
    },
    onPause: () {
      print('StreamController onPause');
    },
    onResume: () {
      print('StreamController onResume');
    },
    onCancel: () {
      print('StreamController onCancel');
    },
  );

  void startTimer() {
    timer = Timer.periodic(interval, (x) {
      tick();
    });
    print('timer created and started');
  }

  void stopTimer() {
    if (timer != null) {
      timer!.cancel();
      timer = null;
      print('timer stopped and killed');
    }
  }

  void tick() {
    counter++;
    if (counter == (maxCount / 2)) {
      // Ask stream to send a string as an error event.
      controller.addError('error event');
    } else {
      // Ask stream to send counter value as a data event.
      controller.add(counter);
    }
    if (counter == maxCount) {
      // Stop and kill the timer instance.
      stopTimer();
      // Ask stream to shut down and tell listeners.
      controller.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text('Press'),
        onPressed: () {
          listenWithPause();
        },
      ),
    );
  }

  void listenWithPause() {
    startTimer();
    StreamSubscription<int> subscription;
    //subscribe to listen to the stream.
    subscription = controller.stream.listen((event) {
      print('StreamSubscription onData: $event');
      if (event == 3) {
        // After 3 ticks, pause for five seconds, then resume.
        // During the pause time the controller will sense this
        // and stop putting events into the stream.
        //subscription.pause(Future.delayed(const Duration(seconds: 10)));
      }
    }, onError: (error) {
      print('StreamSubscription onError: $error');
    }, onDone: () {
      print('StreamSubscription onDone');
    });
  }
}
