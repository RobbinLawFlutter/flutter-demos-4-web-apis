//Dismissable Widget of the Week 1min.
//https://www.youtube.com/watch?v=iEMgjrfuc58&list=PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG&index=29

//flutter_slidable Package of the Week 2min.
//https://www.youtube.com/watch?v=QFcFEpFmNJ8&list=PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG&index=96

//flutter_slidable by Trey Codes
//https://www.youtube.com/watch?v=5kxt_ssl-uE

import 'package:flutter/material.dart';
import 'package:robbinlaw/models/app.dart';
import 'package:robbinlaw/services/database.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

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
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  appModel.content,
                  style: TextStyle(
                    fontSize: 15,
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
