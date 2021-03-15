//ListView Widget of the Week
//https://www.youtube.com/watch?v=KJpkjHGiI5A&vl=en

//TextEditingController Widget
//https://api.flutter.dev/flutter/widgets/TextEditingController-class.html

//TextField Widget
//https://api.flutter.dev/flutter/material/TextField-class.html

import 'package:flutter/material.dart';

// This app does
void main() => runApp(App());

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  List<String> listItems = [];
  final TextEditingController eCtrl = TextEditingController();
  @override
  Widget build(BuildContext ctxt) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Dynamic ListView Builder Demo"),
          ),
          body: Column(
            children: <Widget>[
              TextField(
                controller: eCtrl,
                style: TextStyle(
                  fontSize: 30,
                ),
                onSubmitted: (text) {
                  listItems.add(text);
                  eCtrl.clear();
                  setState(() {});
                },
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: listItems.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return Text(
                          listItems[index],
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        );
                      }))
            ],
          )),
    );
  }
}
