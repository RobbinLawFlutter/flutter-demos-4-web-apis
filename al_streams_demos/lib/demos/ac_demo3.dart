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
        onListen: startTimer,
        onPause: stopTimer,
        onResume: startTimer,
        onCancel: stopTimer);

    return controller.stream;
  }

  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.headline2,
      textAlign: TextAlign.center,
      child: Container(
        alignment: FractionalOffset.center,
        //color: Colors.white,
        child: StreamBuilder<int>(
          stream: timedCounter(const Duration(seconds: 1), 10),
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            List<Widget> children;
            if (snapshot.hasError) {
              children = <Widget>[
                Icon(
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
                    Icon(
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
                    SizedBox(
                      child: const CircularProgressIndicator(),
                      width: 60,
                      height: 60,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Awaiting bids...'),
                    )
                  ];
                  break;
                case ConnectionState.active:
                  children = <Widget>[
                    Icon(
                      Icons.check_circle_outline,
                      color: Colors.green,
                      size: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('\$${snapshot.data}'),
                    )
                  ];
                  break;
                case ConnectionState.done:
                  children = <Widget>[
                    Icon(
                      Icons.info,
                      color: Colors.blue,
                      size: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('\$${snapshot.data} (closed)'),
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
      ),
    );
  }
}
