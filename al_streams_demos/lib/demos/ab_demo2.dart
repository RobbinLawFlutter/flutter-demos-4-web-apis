import 'dart:async';
import 'package:flutter/material.dart';

class Demo2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo 2'),
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
  Stream<int> timedCounter(Duration interval, [int maxCount]) {
    StreamController<int> controller;
    Timer timer;
    int counter = 0;

    void tick(_) {
      counter++;
      if (counter == (maxCount ~/ 2)) {
        controller.addError('error event');
      } else {
        controller.add(counter); // Ask stream to send counter values as event.
      }
      if (counter == maxCount) {
        timer.cancel();
        controller.close(); // Ask stream to shut down and tell listeners.
      }
    }

    void startTimer() {
      timer = Timer.periodic(interval, tick);
    }

    void stopTimer() {
      if (timer != null) {
        timer.cancel();
        timer = null;
      }
    }

    controller = StreamController<int>(
      onListen: () {
        startTimer();
        print('onListen, Start Timer');
      },
      onPause: () {
        stopTimer();
        print('onPause, Stop Timer');
      },
      onResume: () {
        startTimer();
        print('onResume, Start Timer');
      },
      onCancel: () {
        stopTimer();
        print('onCancel, Stop Timer');
      },
    );
    //return the stream that this controller created
    //and controls, but leave the controller behind.
    return controller.stream;
  }

  void listenWithPause() {
    Stream<int> counterStream = timedCounter(const Duration(seconds: 1), 10);
    StreamSubscription<int> subscription;
    //subscribe to listen to the stream.
    subscription = counterStream.listen((event) {
      print(event);
      if (event == 3) {
        // After 3 ticks, pause for five seconds, then resume.
        subscription.pause(Future.delayed(const Duration(seconds: 5)));
      }
    }, onError: (error) {
      print(error);
    }, onDone: () {
      print('Hey Man this stream is done');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        child: Text('Press'),
        onPressed: () {
          listenWithPause();
        },
      ),
    );
  }
}
