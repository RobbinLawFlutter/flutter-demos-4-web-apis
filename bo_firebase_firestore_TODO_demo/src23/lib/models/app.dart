// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

class AppModel {
  late String id;
  late String content;
  late Timestamp dateCreated;
  late bool done;

  //default constructor.
  AppModel({
    required this.id,
    required this.content,
    required this.dateCreated,
    required this.done,
  });

  //named constructor that converts the DocumentSnapshot data from firestore that
  //comes as a map, into our model object.
  AppModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot.id;
    //get the value of the key-value pair by specifying the key.
    //content = documentSnapshot.data()["content"];
    content = documentSnapshot["content"];
    //dateCreated = documentSnapshot.data()["dateCreated"];
    dateCreated = documentSnapshot["dateCreated"];
    //done = documentSnapshot.data()["done"];
    done = documentSnapshot["done"];
    print('AppModel.fromDocumentSnapshot: id: $id content: $content dateCreated: $dateCreated done: $done');
  }
}
