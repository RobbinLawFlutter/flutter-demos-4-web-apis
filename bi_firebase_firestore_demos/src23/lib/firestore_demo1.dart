// ignore_for_file: use_key_in_widget_constructors, avoid_print, library_prefixes

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//Intro to FireStore from Google Futter in Focus series
//https://www.youtube.com/watch?v=DqJ_KjFzL9I&t=7s

//What is a nosql database... 12 videos about FireStore
//https://www.youtube.com/watch?v=v_hR4K4auoQ&list=PLl-K7zZEsYLluG5MCVEzXAQ7ACZBCuZgZ

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Firestore Demo 1"),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: _create,
                child: const Text("Create"),
              ),
              ElevatedButton(
                onPressed: _read,
                child: const Text("Read"),
              ),
              ElevatedButton(
                onPressed: _update,
                child: const Text("Update"),
              ),
              ElevatedButton(
                onPressed: _delete,
                child: const Text("Delete"),
              ),
            ]),
      ),
    );
  }

  void _create() async {
    try {
      await FirebaseFirestore.instance.collection('users').doc('testUser').set({
        'firstName': 'test',
        'lastName': 'user',
      });
      print('successful create');
      
    } catch (e) {
      print('ERROR');
      print(e.toString());
    }
  }

  void _read() async {
    DocumentSnapshot documentSnapshot;
    try {
      documentSnapshot =
          await FirebaseFirestore.instance.collection('users').doc('testUser').get();
      print(documentSnapshot.data());
      
    } catch (e) {
      print('ERROR');
      print(e.toString());
    }
  }

  void _update() async {
    try {
      await FirebaseFirestore.instance.collection('users').doc('testUser').update({
        'firstName': 'testUpdated',
        'lastName': 'userUpdated',
      });
      print('successful update');
      
    } catch (e) {
      print('ERROR');
      print(e.toString());
    }
  }

  void _delete() async {
    try {
      await FirebaseFirestore.instance.collection('users').doc('testUser').delete();
      print('successful delete');
      
    } catch (e) {
      print('ERROR');
      print(e.toString());
    }
  }
}
