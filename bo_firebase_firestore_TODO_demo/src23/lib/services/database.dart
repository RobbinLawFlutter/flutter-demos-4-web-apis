// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:robbinlaw/widgets/mysnackbar.dart';

class Database {
  late BuildContext context;
  Database({required this.context});

  Future<void> createNewUser(String? userId, String? userName, String? userEmail) async {
    print('Database createNewUser: TRY');
    try {
      await FirebaseFirestore.instance.collection("users").doc(userId).set({
        "name": userName,
        "email": userEmail,
      });
      ScaffoldMessenger.of(context)
                    .showSnackBar(MySnackBar(text: 'create new user: SUCCESS').get());
    } catch (e) {
      print('Database createNewUser: CATCH $e.toString');
      ScaffoldMessenger.of(context)
                    .showSnackBar(MySnackBar(text: 'create new user: FAIL').get());
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamOfAppData(String userId) {
    print('Database streamOfAppData: TRY');
    try {
      return FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("todos")
          .orderBy("dateCreated", descending: true)
          .snapshots();
    } catch (e) {
      print('Database streamOfAppData: CATCH $e');
      rethrow;
    }
  }

  Future<void> addAppData(String content, String userId) async {
    print('Database addAppData: TRY');
    try {
      await FirebaseFirestore.instance.collection("users").doc(userId).collection("todos").add({
        'dateCreated': Timestamp.now(),
        'content': content,
        'done': false,
      });
      ScaffoldMessenger.of(context)
                    .showSnackBar(MySnackBar(text: 'add app data: SUCCESS').get());
    } catch (e) {
      print('Database addAppData: CATCH $e.toString');
      ScaffoldMessenger.of(context)
                    .showSnackBar(MySnackBar(text: 'add app data: FAIL').get());
    }
  }

  Future<void> updateAppData(
      bool? newDoneValue, String userId, String appDataId) async {
    print('Database updateAppData: TRY');
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("todos")
          .doc(appDataId)
          .update({"done": newDoneValue});
      ScaffoldMessenger.of(context)
                    .showSnackBar(MySnackBar(text: 'update app data: SUCCESS').get());
    } catch (e) {
      print('Database updateAppData: CATCH $e.toString');
      ScaffoldMessenger.of(context)
                    .showSnackBar(MySnackBar(text: 'update app data: FAIL').get());
    }
  }

  Future<void> deleteAppData(String userId, String appDataId) async {
    print('Database deleteAppData: TRY');
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("todos")
          .doc(appDataId)
          .delete();
      ScaffoldMessenger.of(context)
                    .showSnackBar(MySnackBar(text: 'delete app data: SUCCESS').get());
    } catch (e) {
      print('Database deleteAppData: CATCH $e.toString');
      ScaffoldMessenger.of(context)
                    .showSnackBar(MySnackBar(text: 'delete app data: FAIL').get());
    }
  }
}
