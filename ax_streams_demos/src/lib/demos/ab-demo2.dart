import 'dart:async';
import 'package:flutter/material.dart';

class Demo2 extends StatelessWidget {
  const Demo2 ({Key? key}) : super(key: key);
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
  _MyDemoState createState() => _MyDemoState();
}

class _MyDemoState extends State<MyDemo> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text('Press'),
        onPressed: () {
          listenWithPause();
        },
      ),
    );
  }

  void listenWithPause() {
    Stream<int> counterStream =
        timedCounterStream(const Duration(seconds: 1), 10);
    StreamSubscription<int> subscription;
    //subscribe to listen to the stream.
    subscription = counterStream.listen((event) {
      print(event);
      if (event == 3) {
        //After 3 ticks, pause for five seconds, then resume.
        //During the pause time the controller will sense this
        //and stop putting events into the stream.
        subscription.pause(Future.delayed(const Duration(seconds: 5)));
      }
    }, onError: (error) {
      print('There has been an error event: $error');
    }, onDone: () {
      print('This stream is done');
    });
  }

  Stream<int> timedCounterStream(Duration interval, [int maxCount]) {
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
        //timer.cancel();
        controller.close(); // Ask stream to shut down and tell listeners.
      }
    }

    void startTimer() {
      print('Start Timer');
      //This timer starts at the interval and counts down to 0 in millisecond divs.
      //Then it runs the tick callback, and starts over,
      //so effectively the tick callback is called every interval seconds.
      timer = Timer.periodic(interval, tick);
    }

    void stopTimer() {
      print('Stop Timer');
      if (timer != null) {
        timer.cancel();
        timer = null;
      }
    }

    controller = StreamController<int>(
      onListen: () {
        print('onListen');
        startTimer();
      },
      onPause: () {
        //Here we could stop the timer so no events enter the stream
        //or keep it going and the stream buffer would store them
        //until the subscription resumes listening to the stream events.
        print('onPause');
        stopTimer();
      },
      onResume: () {
        //If we disable the stopTimer of onPause we must
        //also disable the startTimer of onResume.
        print('onResume');
        startTimer();
      },
      onCancel: () {
        print('onCancel');
        stopTimer();
      },
    );
    //return the stream that this controller created
    //and controls, but leave the controller here to
    //continue to control the stream.
    return controller.stream;
  }
}
