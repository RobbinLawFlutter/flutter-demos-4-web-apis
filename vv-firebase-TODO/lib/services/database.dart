import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:robbinlaw/models/app.dart';
import 'package:robbinlaw/models/user.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> createNewUserTodo(UserModel user) async {
    print('Database createNewUserTodo: try');
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

  Future<UserModel> getUserTodo(String uid) async {
    print('Database getUserTodo: try');
    try {
      DocumentSnapshot _doc =
          await _firestore.collection("users").doc(uid).get();
      return UserModel.fromDocumentSnapshot(documentSnapshot: _doc);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<AppModel>> getTodos(String uid) async {
    print('Database getTodos: try');
    try {
      QuerySnapshot _doc = await _firestore
          .collection("users")
          .doc(uid)
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

  Stream<List<AppModel>> streamTodos(String uid) {
    print('Database streamTodos: try');
    try {
      return _firestore
          .collection("users")
          .doc(uid)
          .collection("todos")
          .orderBy("dateCreated", descending: true)
          .snapshots()
          .map((QuerySnapshot query) {
        print('Database streamTodos: try .map');
        List<AppModel> listOfAppModel = List();
        query.docs.forEach((element) {
          print('Database streamTodos: try .map query.docs.forEach');
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

  Future<void> addTodo(String content, String uid) async {
    print('Database addTodo: try');
    try {
      await _firestore.collection("users").doc(uid).collection("todos").add({
        'dateCreated': Timestamp.now(),
        'content': content,
        'done': false,
      });
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> updateTodo(bool newValue, String uid, String todoId) async {
    print('Database updateTodo: try');
    try {
      _firestore
          .collection("users")
          .doc(uid)
          .collection("todos")
          .doc(todoId)
          .update({"done": newValue});
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> deleteTodo(String uid, String todoId) async {
    print('Database deleteTodo: try');
    try {
      _firestore
          .collection("users")
          .doc(uid)
          .collection("todos")
          .doc(todoId)
          .delete();
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
