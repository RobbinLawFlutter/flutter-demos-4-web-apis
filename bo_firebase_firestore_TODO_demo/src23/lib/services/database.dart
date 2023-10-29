// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:robbinlaw/models/app.dart';
import 'package:robbinlaw/models/user.dart';

class Database {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<bool> createNewUser(UserModel user) async {
    print('Database createNewUser: try');
    try {
      await db.collection("users").doc(user.id).set({
        "name": user.name,
        "email": user.email,
      });
      return true;
    } catch (e) {
      print('Database createNewUser: catch $e');
      return false;
    }
  }

  Stream<List<AppModel>> streamOfAppData(String userId) {
    print('Database streamOfAppData: try');
    try {
      return db
          .collection("users")
          .doc(userId)
          .collection("todos")
          .orderBy("dateCreated", descending: true)
          .snapshots()
          .map((QuerySnapshot query) {
        List<AppModel> listOfAppModel = [];
        query.docs.forEach((element) {
          listOfAppModel
              .add(AppModel.fromDocumentSnapshot(documentSnapshot: element));
        });
        return listOfAppModel;
      });
    } catch (e) {
      print('Database streamOfAppData: catch $e');
      rethrow;
    }
  }

  Future<void> addAppData(String content, String userId) async {
    print('Database addAppData: try');
    try {
      await db.collection("users").doc(userId).collection("todos").add({
        'dateCreated': Timestamp.now(),
        'content': content,
        'done': false,
      });
    } catch (e) {
      print('Database addAppData: catch $e');
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

  Future<String> getUserName(String userId) async {
    print('Database getUserName: try');
    try {
      DocumentSnapshot documentSnapshot =
          await db.collection("users").doc(userId).get();
      return UserModel.fromDocumentSnapshot(documentSnapshot: documentSnapshot)
          .name;
    } catch (e) {
      print('Database getUserName: catch $e');
      rethrow;
    }
  }

  Future<List<AppModel>> futureOfAppData(String userId) async {
    print('Database futureOfAppData: try');
    try {
      QuerySnapshot doc =
          await db.collection("users").doc(userId).collection("todos").get();
      List<AppModel> listOfAppModel = [];
      doc.docs.forEach((element) {
        listOfAppModel
            .add(AppModel.fromDocumentSnapshot(documentSnapshot: element));
      });
      return listOfAppModel;
    } catch (e) {
      print('Database futureOfAppData: catch $e');
      rethrow;
    }
  }
}
