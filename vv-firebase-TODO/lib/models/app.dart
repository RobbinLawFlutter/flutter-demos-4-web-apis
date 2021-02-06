import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppModel {
  String id;
  String content;
  Timestamp dateCreated;
  bool done;

  AppModel({
    @required this.id,
    @required this.content,
    @required this.dateCreated,
    @required this.done,
  });

  AppModel.fromDocumentSnapshot({DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot.id;
    content = documentSnapshot.data()["content"];
    print('AppModel.fromDocumentSnapshot: content= $content');
    dateCreated = documentSnapshot.data()["dateCreated"];
    done = documentSnapshot.data()["done"];
  }
}
