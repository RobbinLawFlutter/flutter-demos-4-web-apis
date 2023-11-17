// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:robbinlaw/services/database.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

//Dismissible Widget of the Week 1min.
//https://www.youtube.com/watch?v=iEMgjrfuc58&list=PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG&index=29

//flutter_slidable Package of the Week 2min.
//https://www.youtube.com/watch?v=QFcFEpFmNJ8&list=PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG&index=96

//flutter_slidable by Trey Codes
//https://www.youtube.com/watch?v=5kxt_ssl-uE

class MyCardWithSlidable extends StatelessWidget {
  final String userId;
  final QueryDocumentSnapshot<Map<String, dynamic>> document;

  const MyCardWithSlidable(
      {required Key key, required this.userId, required this.document})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //print(document.id);
    //print(document.data());
    return Slidable(
      key: Key('app-${document.id}'),
      // The start action pane is the one at the left or the top side.
      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        // A pane can dismiss the Slidable.
        //dismissible: DismissiblePane(onDismissed: () {}),

        // All actions are defined in the children parameter.
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: (context) {
              try {
                Database().deleteAppData(userId, document.id);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    duration: Duration(seconds: 1),
                    content: Text('todo deleted'),
                  ),
                );
              } catch (e) {
                print('MyCardWithSlidable: CATCH $e');
              }
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
          SlidableAction(
            onPressed: (context) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  duration: Duration(seconds: 1),
                  content: Text('todo shared'),
                ),
              );
            },
            backgroundColor: const Color(0xFF21B7CA),
            foregroundColor: Colors.white,
            icon: Icons.share,
            label: 'Share',
          ),
        ],
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  document.data()['content'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Checkbox(
                value: document.data()['done'],
                onChanged: (newValue) {
                  try {
                    Database().updateAppData(newValue, userId, document.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(seconds: 1),
                        content: Text('todo updated'),
                      ),
                    );
                  } catch (e) {
                    print('MyCardWithSlidable: CATCH $e');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyCardWithDismissible extends StatelessWidget {
  final String userId;
  final QueryDocumentSnapshot<Map<String, dynamic>> document;

  const MyCardWithDismissible(
      {required Key key, required this.userId, required this.document})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //print(document.id);
    //print(document.data());
    return Dismissible(
      key: Key('app-${document.id}'),
      background: Container(color: Colors.red),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        try {
          Database().deleteAppData(userId, document.id);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              duration: Duration(seconds: 1),
              content: Text('todo deleted'),
            ),
          );
        } catch (e) {
          print('MyCardWithDismissible: CATCH $e');
        }
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  document.data()['content'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Checkbox(
                value: document.data()['done'],
                onChanged: (newValue) {
                  try {
                    Database().updateAppData(newValue, userId, document.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(seconds: 1),
                        content: Text('todo updated'),
                      ),
                    );
                  } catch (e) {
                    print('MyCardWithDismissible: CATCH $e');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
