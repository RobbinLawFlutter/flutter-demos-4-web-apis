import 'package:flutter/material.dart';
import 'dart:io';

class Demo1 extends StatelessWidget {
  const Demo1 ({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo1'),
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
  List<String> listItems = [];
  final TextEditingController eCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: eCtrl,
          style: const TextStyle(
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
                itemBuilder: (BuildContext context, int index) {
                  return Text(
                    listItems[index],
                    style: const TextStyle(
                      fontSize: 30,
                    ),
                  );
                }))
      ],
    );
  }
}
