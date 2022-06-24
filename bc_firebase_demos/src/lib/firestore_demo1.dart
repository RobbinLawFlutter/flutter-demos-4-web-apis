//Intro to FireStore from Google Futter in Focus series
//https://www.youtube.com/watch?v=DqJ_KjFzL9I&t=7s

//What is a nosql database... 12 videos about FireStore
//https://www.youtube.com/watch?v=v_hR4K4auoQ&list=PLl-K7zZEsYLluG5MCVEzXAQ7ACZBCuZgZ

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
        title: Text("Flutter Firestore Demo 1"),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                child: Text("Create"),
                onPressed: _create,
              ),
              ElevatedButton(
                child: Text("Read"),
                onPressed: _read,
              ),
              ElevatedButton(
                child: Text("Update"),
                onPressed: _update,
              ),
              ElevatedButton(
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
      Get.snackbar(
        "successful create",
        '',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
      );
    } catch (e) {
      Get.snackbar(
        "create ERROR",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 5),
      );
    }
  }

  void _read() async {
    DocumentSnapshot documentSnapshot;
    try {
      documentSnapshot =
          await firestore.collection('users').doc('testUser').get();
      print(documentSnapshot.data());
      Get.snackbar(
        "successful read",
        '${documentSnapshot.data()}',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
      );
    } catch (e) {
      Get.snackbar(
        "read ERROR",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 5),
      );
    }
  }

  void _update() async {
    try {
      await firestore.collection('users').doc('testUser').update({
        'firstName': 'testUpdated',
        'lastName': 'userUpdated',
      });
      print('successful update');
      Get.snackbar(
        "successful update",
        '',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
      );
    } catch (e) {
      Get.snackbar(
        "update ERROR",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 5),
      );
    }
  }

  void _delete() async {
    try {
      await firestore.collection('users').doc('testUser').delete();
      print('successful delete');
      Get.snackbar(
        "successful delete",
        '',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
      );
    } catch (e) {
      Get.snackbar(
        "delete ERROR",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 5),
      );
    }
  }
}
