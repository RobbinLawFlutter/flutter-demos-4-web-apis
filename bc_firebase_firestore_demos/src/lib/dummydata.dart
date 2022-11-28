// ignore_for_file: use_key_in_widget_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;

final dummyListOfMaps = [
  //{"name": "Jimmy", "votes": null},
  {"name": "Filip", "votes": 15},
  {"name": "Abraham", "votes": 14},
  {"name": "Richard", "votes": 11},
  {"name": "Ike", "votes": 10},
  {"name": "Justin", "votes": 1},
];

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Baby Name Votes')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return _buildList(context, dummyListOfMaps);
  }

  Widget _buildList(
      BuildContext context, List<Map<String, dynamic>> listOfMaps) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: listOfMaps
          .map((dataMap) => _buildListItem(context, dataMap))
          .toList(),
    );
  }

  Widget _buildListItem(BuildContext context, Map<String, dynamic> dataMap) {
    final record = Record.fromMap(dataMap);

    return Padding(
      key: ValueKey(record.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(record.name),
          trailing: Text(record.votes.toString()),
          onTap: () => print(record),
        ),
      ),
    );
  }
}

class Record {
  final String name;
  final int votes;

  //Redirecting Constuctors and optional parameters
  //https://bezkoder.com/dart-flutter-constructors/#Redirecting_Constructor

  //Using an initializer list
  //https://dart.dev/guides/language/language-tour#using-constructors

  //How assert works from the medium community.
  //https://medium.com/run-dart/dart-dartlang-introduction-advanced-dart-features-524de79456b9

  Record.fromMap(Map<String, dynamic> map)
      : assert(map['name'] != null),
        assert(map['votes'] != null),
        name = map['name'],
        votes = map['votes'];

  @override
  String toString() => "Record<$name:$votes>";
}
