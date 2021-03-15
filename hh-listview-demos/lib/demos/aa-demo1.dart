import 'package:flutter/material.dart';
import 'dart:io';

class Demo1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo1'),
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
  List<String> listItems = [];
  final TextEditingController eCtrl = TextEditingController();
  @override
  Widget build(BuildContext ctxt) {
    return Column(
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
    );
  }
}
