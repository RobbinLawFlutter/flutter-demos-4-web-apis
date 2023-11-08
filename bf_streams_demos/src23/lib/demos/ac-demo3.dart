// ignore_for_file: use_key_in_widget_constructors, file_names, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'dart:async';

class Demo3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo 3'),
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
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: FractionalOffset.center,
      //color: Colors.white,
      child: StreamBuilder<int>(
        stream: timedCounterStream(const Duration(seconds: 2), 10),
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          List<Widget> children;
          if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              )
            ];
          } else {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                children = <Widget>[
                  const Icon(
                    Icons.info,
                    color: Colors.blue,
                    size: 60,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Select a lot'),
                  )
                ];
                break;
              case ConnectionState.waiting:
                children = <Widget>[
                  const SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Awaiting bids...'),
                  )
                ];
                break;
              case ConnectionState.active:
                children = <Widget>[
                  const Icon(
                    Icons.check_circle_outline,
                    color: Colors.green,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('\$${snapshot.data} (active)'),
                  )
                ];
                break;
              case ConnectionState.done:
                children = <Widget>[
                  const Icon(
                    Icons.info,
                    color: Colors.blue,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('\$${snapshot.data} (done)'),
                  )
                ];
                break;
            }
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: children,
          );
        },
      ),
    );
  }

  Stream<int> timedCounterStream(Duration interval, [int maxCount = 5]) {
    StreamController<int> controller = StreamController<int>();
    Timer? timer;
    int counter = 0;

    void tick(_) {
      counter++;
      if (counter == (maxCount ~/ 2)) {
        controller.addError('error event');
      } else {
        controller.add(counter); // Ask stream to send counter values as event.
      }
      if (counter == maxCount) {
        timer!.cancel();
        controller.close(); // Ask stream to shut down and tell listeners.
      }
    }

    void startTimer() {
      timer = Timer.periodic(interval, tick);
    }

    void stopTimer() {
      if (timer != null) {
        timer!.cancel();
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
    return controller.stream;
  }
}
