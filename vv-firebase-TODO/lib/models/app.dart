import 'package:cloud_firestore/cloud_firestore.dart';

// class AppModel {
//   String symbol;
//   String name;
//   //num type can be an integer or a double.
//   num price;
//   //random

//   AppModel({this.symbol, this.name, this.price});

//   Map<String, dynamic> toMap() {
//     return {
//       'symbol': symbol,
//       'name': name,
//       'price': price,
//     };
//   }

//   AppModel.fromDocumentSnapshot({DocumentSnapshot documentSnapshot}) {
//     id = documentSnapshot.id;
//     content = documentSnapshot.data()["content"];
//     print('AppModel.fromDocumentSnapshot: content= $content');
//     dateCreated = documentSnapshot.data()["dateCreated"];
//     done = documentSnapshot.data()["done"];
//   }
// }

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
