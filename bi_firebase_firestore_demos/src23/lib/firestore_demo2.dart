// ignore_for_file: use_key_in_widget_constructors, avoid_print, library_prefixes

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      body: Column(
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('baby')
                .snapshots(),
            builder: (context, snapshot) {
              print('demo2 StreamBuilder builder');
              if (snapshot.data == null) {
                print('no data yet');
                return const LinearProgressIndicator();
              }
              print('yes data');
              var listOfDocs = snapshot.data!.docs;
              return Expanded(
                child: ListView.builder(
                    itemCount: listOfDocs.length,
                    itemBuilder: (BuildContext context, index) {
                      var doc = listOfDocs[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: ListTile(
                              title: Text(doc.data()['name']),
                              trailing:
                                  Text(doc.data()['votes'].toString()),
                              onTap: () {
                                doc.reference.update({
                                  'votes': FieldValue.increment(1)
                                });
                              }),
                        ),
                      );
                    }),
              );
            },
          ),
        ],
      ),
    );
  }
}
