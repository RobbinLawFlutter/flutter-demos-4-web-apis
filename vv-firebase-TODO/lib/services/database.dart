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
      print(e);
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
      print(e);
      rethrow;
    }
  }

  Future<List<AppModel>> getAppData(String userId) async {
    print('Database getAppData: try');
    try {
      QuerySnapshot _doc = await _firestore
          .collection("users")
          .doc(userId)
          .collection("todos")
          .get();
      List<AppModel> listOfAppModel = List();
      _doc.docs.forEach((element) {
        listOfAppModel
            .add(AppModel.fromDocumentSnapshot(documentSnapshot: element));
      });
      return listOfAppModel;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Stream<List<AppModel>> streamAppData(String userId) {
    print('Database streamAppData: try');
    try {
      return _firestore
          .collection("users")
          .doc(userId)
          .collection("todos")
          .orderBy("dateCreated", descending: true)
          .snapshots()
          .map((QuerySnapshot query) {
        print('Database streamAppData: try .map');
        List<AppModel> listOfAppModel = List();
        query.docs.forEach((element) {
          print('Database streamAppData: try .map query.docs.forEach');
          listOfAppModel
              .add(AppModel.fromDocumentSnapshot(documentSnapshot: element));
        });
        return listOfAppModel;
      });
    } catch (e) {
      print(e);
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
      print(e);
      rethrow;
    }
  }

  Future<void> updateAppData(
      bool newValue, String userId, String todoId) async {
    print('Database updateAppData: try');
    try {
      _firestore
          .collection("users")
          .doc(userId)
          .collection("todos")
          .doc(todoId)
          .update({"done": newValue});
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> deleteAppData(String userId, String todoId) async {
    print('Database deleteAppData: try');
    try {
      _firestore
          .collection("users")
          .doc(userId)
          .collection("todos")
          .doc(todoId)
          .delete();
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
