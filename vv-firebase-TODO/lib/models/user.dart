import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String name;
  String email;

  UserModel({
    @required this.id,
    @required this.name,
    @required this.email,
  });

  UserModel.fromDocumentSnapshot({DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot.id;
    name = documentSnapshot.data()["name"];
    email = documentSnapshot["email"];
    print('UserModel.fromDocumentSnapshot: name= $name');
  }
}
