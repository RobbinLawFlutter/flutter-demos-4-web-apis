import 'dart:async';
import 'package:flutter/material.dart';

class Demo2 extends StatelessWidget {
  Demo2({this.title});

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
  Stream<int> _bids = (() async* {
    await Future<void>.delayed(Duration(seconds: 1));
    yield 1;
    await Future<void>.delayed(Duration(seconds: 1));
  })();
// Flutter code sample for StreamBuilder
// This sample shows a [StreamBuilder] that listens to a Stream that emits bids
// for an auction. Every time the StreamBuilder receives a bid from the Stream,
// it will display the price of the bid below an icon. If the Stream emits an
// error, the error is displayed below an error icon. When the Stream finishes
// emitting bids, the final price is displayed.
// This is the stateful widget that the main application instantiates.
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.headline2,
      textAlign: TextAlign.center,
      child: Container(
        alignment: FractionalOffset.center,
        color: Colors.white,
        child: StreamBuilder<int>(
          stream: _bids,
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
