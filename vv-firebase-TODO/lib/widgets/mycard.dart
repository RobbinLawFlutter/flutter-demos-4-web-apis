import 'package:flutter/material.dart';
import 'package:robbinlaw/models/app.dart';
import 'package:robbinlaw/services/database.dart';

class MyCard extends StatelessWidget {
  final String uid;
  final AppModel app;

  const MyCard({Key key, this.uid, this.app}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('app-${app.id}'),
      background: Container(color: Colors.red),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => Database().deleteTodo(uid, app.id),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  app.content,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Checkbox(
                value: app.done,
                onChanged: (newValue) {
                  Database().updateTodo(newValue, uid, app.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
