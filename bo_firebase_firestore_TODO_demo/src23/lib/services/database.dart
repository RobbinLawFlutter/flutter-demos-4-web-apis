// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> createNewUser(String? userId, String? userName, String? userEmail) async {
    print('Database createNewUser: TRY');
    try {
      await db.collection("users").doc(userId).set({
        "name": userName,
        "email": userEmail,
      });
    } catch (e) {
      print('Database createNewUser: CATCH $e');
      rethrow;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamOfAppData(String userId) {
    print('Database streamOfAppData: TRY');
    try {
      return db
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
      await db.collection("users").doc(userId).collection("todos").add({
        'dateCreated': Timestamp.now(),
        'content': content,
        'done': false,
      });
    } catch (e) {
      print('Database addAppData: CATCH $e');
      rethrow;
    }
  }

  Future<void> updateAppData(
      bool? newDoneValue, String userId, String appDataId) async {
    print('Database updateAppData: try');
    try {
      await db
          .collection("users")
          .doc(userId)
          .collection("todos")
          .doc(appDataId)
          .update({"done": newDoneValue});
    } catch (e) {
      print('Database updateAppData: catch $e');
      rethrow;
    }
  }

  Future<void> deleteAppData(String userId, String appDataId) async {
    print('Database deleteAppData: try');
    try {
      await db
          .collection("users")
          .doc(userId)
          .collection("todos")
          .doc(appDataId)
          .delete();
    } catch (e) {
      print('Database deleteAppData: catch $e');
      rethrow;
    }
  }
}
