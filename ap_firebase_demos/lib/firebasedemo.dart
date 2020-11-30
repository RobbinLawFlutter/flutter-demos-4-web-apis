//This demo is from the following codelab.
//https://codelabs.developers.google.com/codelabs/flutter-firebase#1

//Intro to FireStore from Google Futter in Focus series
//https://www.youtube.com/watch?v=DqJ_KjFzL9I&t=7s

//What is a nosql database... 12 videos about FireStore
//https://www.youtube.com/watch?v=v_hR4K4auoQ&list=PLl-K7zZEsYLluG5MCVEzXAQ7ACZBCuZgZ

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Baby Name Votes')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    //streams from Google Flutter in Focus series.
    //https://www.youtube.com/watch?v=nQBpOIHE4eE&list=PLjxrf2q8roU2HdJQDjJzOeO6J3FoFLWr2&index=16

    return StreamBuilder<firestore.QuerySnapshot>(
      stream:
          firestore.FirebaseFirestore.instance.collection('baby').snapshots(),
      builder: (context, snapshots) {
        if (!snapshots.hasData) return LinearProgressIndicator();
        return _buildList(context, snapshots.data.docs);
      },
    );
  }

  Widget _buildList(
      BuildContext context, List<firestore.DocumentSnapshot> snapshots) {
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

  //Redirecting Contstuctors and optional parameters
  //https://bezkoder.com/dart-flutter-constructors/#Redirecting_Constructor
  Record.fromSnapshot(firestore.DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  //Using an initializer list
  //https://dart.dev/guides/language/language-tour#using-constructors

  //How assert works
  //https://medium.com/run-dart/dart-dartlang-introduction-advanced-dart-features-524de79456b9

  //this.reference is a named optional parameter.
  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['votes'] != null),
        name = map['name'],
        votes = map['votes'] {
    //Get an objects type with .runtimeType
    print(this.reference.runtimeType);
  }

  @override
  String toString() => "Record<$name:$votes>";
}
