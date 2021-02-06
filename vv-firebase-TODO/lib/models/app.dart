import 'package:cloud_firestore/cloud_firestore.dart';

class AppModel {
  String id;
  String content;
  Timestamp dateCreated;
  bool done;

  AppModel({
    this.id,
    this.content,
    this.dateCreated,
    this.done,
  });

  AppModel.fromDocumentSnapshot({DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot.id;
    content = documentSnapshot.data()["content"];
    print('AppModel.fromDocumentSnapshot: content= $content');
    dateCreated = documentSnapshot.data()["dateCreated"];
    done = documentSnapshot.data()["done"];
  }
}
