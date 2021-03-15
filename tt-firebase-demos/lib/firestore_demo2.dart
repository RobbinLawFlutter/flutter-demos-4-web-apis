import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Firestore Demo 2"),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text("Create"),
                onPressed: _create,
              ),
              RaisedButton(
                child: Text("Read"),
                onPressed: _read,
              ),
              RaisedButton(
                child: Text("Update"),
                onPressed: _update,
              ),
              RaisedButton(
                child: Text("Delete"),
                onPressed: _delete,
              ),
            ]),
      ),
    );
  }

  void _create() async {
    try {
      await firestore.collection('users').doc('testUser').set({
        'firstName': 'test',
        'lastName': 'user',
      });
      print('successful create');
    } catch (e) {
      print(e);
    }
  }

  void _read() async {
    DocumentSnapshot documentSnapshot;
    try {
      documentSnapshot =
          await firestore.collection('users').doc('testUser').get();
      print(documentSnapshot.data());
    } catch (e) {
      print(e);
    }
  }

  void _update() async {
    try {
      await firestore.collection('users').doc('testUser').update({
        'firstName': 'testUpdated',
      });
      print('successful update');
    } catch (e) {
      print(e);
    }
  }

  void _delete() async {
    try {
      await firestore.collection('users').doc('testUser').delete();
      print('successful delete');
    } catch (e) {
      print(e);
    }
  }
}
