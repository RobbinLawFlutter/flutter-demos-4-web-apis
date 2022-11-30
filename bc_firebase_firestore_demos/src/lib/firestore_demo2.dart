//Intro to FireStore from Google Futter in Focus series
//https://www.youtube.com/watch?v=DqJ_KjFzL9I&t=7s

//What is a nosql database... 12 videos about FireStore
//https://www.youtube.com/watch?v=v_hR4K4auoQ&list=PLl-K7zZEsYLluG5MCVEzXAQ7ACZBCuZgZ

// ignore_for_file: use_key_in_widget_constructors, avoid_print, library_prefixes

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;

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
    return StreamBuilder<firestore.QuerySnapshot>(
      stream:
          firestore.FirebaseFirestore.instance.collection('baby').snapshots(),
      builder: (context, snapshot) {
        print('demo2 _buildBody StreamBuilder builder');
        if (!snapshot.hasData) {
          print('no data yet');
          return const LinearProgressIndicator();
        }
        print('yes data');
        return _buildList(context, snapshot.data!.docs);
      },
    );
  }

  Widget _buildList(
      BuildContext context, List<firestore.DocumentSnapshot> snapshots) {
    print('demo2 _buildList');
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshots
          .map((snapshot) => _buildListItem(context, snapshot))
          .toList(),
    );
  }

  Widget _buildListItem(
      BuildContext context, firestore.DocumentSnapshot snapshot) {
    final record = Record.fromSnapshot(snapshot);
    print('demo2 _buildListItem with ${record.name}');
    return Padding(
      //key: ValueKey(record.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        //ListTile can act as a button with onTap property.
        child: ListTile(
            title: Text(record.name),
            trailing: Text(record.votes.toString()),
            onTap: () {
              print(record);
              record.reference
                  .update({'votes': firestore.FieldValue.increment(1)});
            }),
      ),
    );
  }
}

class Record {
  final String name;
  final int votes;
  final firestore.DocumentReference reference;

  //Redirecting Constructors and optional parameters
  //https://bezkoder.com/dart-flutter-constructors/#Redirecting_Constructor
  Record.fromSnapshot(firestore.DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>,
            reference: snapshot.reference);

  //Using an initializer list
  //https://dart.dev/guides/language/language-tour#using-constructors

  //How assert works
  //https://medium.com/run-dart/dart-dartlang-introduction-advanced-dart-features-524de79456b9

  //this.reference is a named optional parameter,
  //but because of required reserved word
  //is not optional.
  Record.fromMap(Map<String, dynamic> map, {required this.reference})
      : assert(map['name'] != null),
        assert(map['votes'] != null),
        name = map['name'],
        votes = map['votes'] {
    //Get an objects type with .runtimeType
    //print(reference.runtimeType);
  }

  @override
  String toString() => "Record<$name:$votes>";
}
