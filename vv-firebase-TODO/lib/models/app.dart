import 'package:cloud_firestore/cloud_firestore.dart';

class AppModel {
  String id;
  String content;
  Timestamp dateCreated;
  bool done;

  //default constructor.
  AppModel({
    this.id,
    this.content,
    this.dateCreated,
    this.done,
  });

  //named constructor that converts the DocumentSnapshot data from firestore that
  //comes as a map, into our model object.
  AppModel.fromDocumentSnapshot({DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot.id;
    //get the value of the key-value pair by specifying the key.
    content = documentSnapshot.data()["content"];
    print('AppModel.fromDocumentSnapshot: content= $content');
    dateCreated = documentSnapshot.data()["dateCreated"];
    done = documentSnapshot.data()["done"];
  }
}
