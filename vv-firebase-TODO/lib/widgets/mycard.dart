//Dismissable Widget of the Week 1min.
//https://www.youtube.com/watch?v=iEMgjrfuc58&list=PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG&index=29

//flutter_slidable Package of the Week 2min.
//https://www.youtube.com/watch?v=QFcFEpFmNJ8&list=PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG&index=96

import 'package:flutter/material.dart';
import 'package:robbinlaw/models/app.dart';
import 'package:robbinlaw/services/database.dart';

class MyCard extends StatelessWidget {
  final String userId;
  final AppModel appModel;

  const MyCard({Key key, this.userId, this.appModel}) : super(key: key);

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
