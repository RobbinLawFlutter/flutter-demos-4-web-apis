// ignore_for_file: use_key_in_widget_constructors, avoid_print, library_prefixes, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:robbinlaw/widgets/mysnackbar.dart';

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
                onPressed: create,
                child: const Text("Create"),
              ),
              ElevatedButton(
                onPressed: read,
                child: const Text("Read"),
              ),
              ElevatedButton(
                onPressed: update,
                child: const Text("Update"),
              ),
              ElevatedButton(
                onPressed: delete,
                child: const Text("Delete"),
              ),
            ]),
      ),
    );
  }

  void create() async {
    try {
      await FirebaseFirestore.instance.collection('users').doc('testUser').set({
        'firstName': 'test',
        'lastName': 'user',
      });
      ScaffoldMessenger.of(context)
                    .showSnackBar(MySnackBar(text: 'create: SUCCESS').get());
      
    } catch (e) {
      ScaffoldMessenger.of(context)
                    .showSnackBar(MySnackBar(text: 'create: FAILED').get());
    }
  }

  void read() async {
    DocumentSnapshot documentSnapshot;
    try {
      documentSnapshot =
          await FirebaseFirestore.instance.collection('users').doc('testUser').get();
      print(documentSnapshot.data());
      ScaffoldMessenger.of(context)
                    .showSnackBar(MySnackBar(text: 'read: SUCCESS').get());
      
    } catch (e) {
      ScaffoldMessenger.of(context)
                    .showSnackBar(MySnackBar(text: 'read: FAILED').get());
    }
  }

  void update() async {
    try {
      await FirebaseFirestore.instance.collection('users').doc('testUser').update({
        'firstName': 'testUpdated',
        'lastName': 'userUpdated',
      });
      ScaffoldMessenger.of(context)
                    .showSnackBar(MySnackBar(text: 'update: SUCCESS').get());
      
    } catch (e) {
      ScaffoldMessenger.of(context)
                    .showSnackBar(MySnackBar(text: 'update: FAILED').get());
    }
  }

  void delete() async {
    try {
      await FirebaseFirestore.instance.collection('users').doc('testUser').delete();
      ScaffoldMessenger.of(context)
                    .showSnackBar(MySnackBar(text: 'delete: SUCCESS').get());
    } catch (e) {
      ScaffoldMessenger.of(context)
                    .showSnackBar(MySnackBar(text: 'delete: FAILED').get());
    }
  }
}
