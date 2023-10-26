// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:robbinlaw/models/app.dart';
import 'package:robbinlaw/models/user.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> createNewUser(UserModel user) async {
    print('Database createNewUser: try');
    try {
      await _firestore.collection("users").doc(user.id).set({
        "name": user.name,
        "email": user.email,
      });
      return true;
    } catch (e) {
      print('Database createNewUser: catch $e');
      return false;
    }
  }

  Future<UserModel> getUser(String userId) async {
    print('Database getUser: try');
    try {
      DocumentSnapshot _documentSnapshot =
          await _firestore.collection("users").doc(userId).get();
      return UserModel.fromDocumentSnapshot(
          documentSnapshot: _documentSnapshot);
    } catch (e) {
      print('Database getUser: catch $e');
      rethrow;
    }
  }

  Future<List<AppModel>> futureOfAppData(String userId) async {
    print('Database futureOfAppData: try');
    try {
      QuerySnapshot _doc = await _firestore
          .collection("users")
          .doc(userId)
          .collection("todos")
          .get();
      List<AppModel> listOfAppModel = [];
      _doc.docs.forEach((element) {
        listOfAppModel
            .add(AppModel.fromDocumentSnapshot(documentSnapshot: element));
      });
      return listOfAppModel;
    } catch (e) {
      print('Database futureOfAppData: catch $e');
      rethrow;
    }
  }

  Stream<List<AppModel>> streamOfAppData(String userId) {
    print('Database streamOfAppData: try');
    try {
      return _firestore
          .collection("users")
          .doc(userId)
          .collection("todos")
          .orderBy("dateCreated", descending: true)
          .snapshots()
          .map((QuerySnapshot query) {
        print('Database streamOfAppData: try .map');
        List<AppModel> listOfAppModel = [];
        query.docs.forEach((element) {
          print('Database streamOfAppData: try .map query.docs.forEach');
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
      await _firestore.collection("users").doc(userId).collection("todos").add({
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
      _firestore
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
      _firestore
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
