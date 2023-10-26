// ignore_for_file: use_key_in_widget_constructors, avoid_print, library_prefixes, unused_import

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;

//Intro to FireStore from Google Futter in Focus series
//https://www.youtube.com/watch?v=DqJ_KjFzL9I&t=7s

//What is a nosql database... 12 videos about FireStore
//https://www.youtube.com/watch?v=v_hR4K4auoQ&list=PLl-K7zZEsYLluG5MCVEzXAQ7ACZBCuZgZ

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Baby Name Votes')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<firestore.QuerySnapshot>(
      stream:
          firestore.FirebaseFirestore.instance.collection('baby').snapshots(),
      builder: (context, snapshot) {
        print('demo2 _buildBody StreamBuilder builder');
        if (!snapshot.hasData) {
          print('no data yet');
          return const LinearProgressIndicator();
        }
        print('yes data');
        return _buildList(context, snapshot.data!.docs);
      },
    );
  }

  Widget _buildList(
      BuildContext context, List<firestore.DocumentSnapshot> listofdocumentsnapshots) {
    print('demo2 _buildList');
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: listofdocumentsnapshots
          .map((documentsnapshot) => _buildListItem(context, documentsnapshot))
          .toList(),
    );
  }

  Widget _buildListItem(
      BuildContext context, firestore.DocumentSnapshot documentsnapshot) {
    var documentdata = documentsnapshot.data() as Map<String, dynamic>;
    print('Name: ${documentdata['name']}, Votes: ${documentdata['votes']}');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
            title: Text(documentdata['name']),
            trailing: Text(documentdata['votes'].toString()),
            onTap: () {
              documentsnapshot.reference
                  .update({'votes': firestore.FieldValue.increment(1)});
            }),
      ),
    );
  }
}
