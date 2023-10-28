//Dismissible Widget of the Week 1min.
//https://www.youtube.com/watch?v=iEMgjrfuc58&list=PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG&index=29

//flutter_slidable Package of the Week 2min.
//https://www.youtube.com/watch?v=QFcFEpFmNJ8&list=PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG&index=96

//flutter_slidable by Trey Codes
//https://www.youtube.com/watch?v=5kxt_ssl-uE

// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:robbinlaw/models/app.dart';
import 'package:robbinlaw/services/database.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MyCardWithSlidable extends StatelessWidget {
  final String userId;
  final AppModel appModel;

  const MyCardWithSlidable(
      {required Key key, required this.userId, required this.appModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: Key('app-${appModel.id}'),
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
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('delete'),
                ),
              );
              Database().deleteAppData(userId, appModel.id);
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
                  content: Text('share'),
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
                  appModel.content,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Checkbox(
                value: appModel.done,
                onChanged: (newValue) {
                  Database().updateAppData(newValue, userId, appModel.id);
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
  final AppModel appModel;

  const MyCardWithDismissible(
      {required Key key, required this.userId, required this.appModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('app-${appModel.id}'),
      background: Container(color: Colors.red),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        print('MyCard build: Dismissible onDismissed:');
        Database().deleteAppData(userId, appModel.id);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  appModel.content,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Checkbox(
                value: appModel.done,
                onChanged: (newValue) {
                  print('MyCard build: Checkbox onChanged:');
                  Database().updateAppData(newValue, userId, appModel.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
