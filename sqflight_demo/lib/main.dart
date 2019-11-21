import 'package:flutter/material.dart';
import 'dart:async';
import 'dog_list.dart';
import 'dog.dart';

import 'package:path/path.dart' as pathPackage;
import 'package:sqflite/sqflite.dart' as sqflitePackage;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: MyDataApp(),
    );
  }
}

class MyDataApp extends StatefulWidget {
  MyDataApp({
    Key key,
  }) : super(key: key);

  @override
  _MyDataAppState createState() => _MyDataAppState();
}

class _MyDataAppState extends State<MyDataApp> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  var _dogList = List<Dog>();
  String _dogName = "";

  @override
  void initState() {
    super.initState();
    runTheCode();
  }

  void runTheCode() async {
    await databaseHelper.getOrCreateDatabaseHandle();
  }

  Future<Null> _inputDog() async {
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: const Text('Input Dogs Name'),
            contentPadding: EdgeInsets.all(5.0),
            content: new TextField(
              decoration: new InputDecoration(hintText: "Dogs Name"),
              onChanged: (String value) {
                _dogName = value;
              },
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Ok"),
                onPressed: () async {
                  if (_dogName.isNotEmpty) {
                    await databaseHelper.insertDog(
                        Dog(id: _dogList.length, name: _dogName, age: 5));
                    databaseHelper.printDogs();
                    setState(() {
                      _dogList
                          .add(new Dog(id: _dogList.length, name: _dogName));
                    });
                  }
                  _dogName = "";
                  Navigator.pop(context);
                },
              ),
              new FlatButton(
                child: new Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('db Demo'),
      ),
      body: new Container(
        child: new Center(
          child: new DogList(dogs: _dogList),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () => _inputDog(),
        tooltip: 'Add',
        child: new Icon(Icons.add),
      ),
    );
  }
}

class DatabaseHelper {
  sqflitePackage.Database db;

  Future<void> getOrCreateDatabaseHandle() async {
    var databasesPath = await sqflitePackage.getDatabasesPath();
    var path = pathPackage.join(databasesPath, 'doggie_database.db');
    print('$path');
    db = await sqflitePackage.openDatabase(
      path,
      onCreate: (sqflitePackage.Database db1, int version) async {
        await db1.execute(
          "CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertDog(Dog dog) async {
    // Insert the Dog into the correct table. Also specify the
    // `conflictAlgorithm`. In this case, if the same dog is inserted
    // multiple times, it replaces the previous data.
    await db.insert(
      'dogs',
      dog.toMap(),
      conflictAlgorithm: sqflitePackage.ConflictAlgorithm.replace,
    );
  }

  Future<void> printDogs() async {
    List<Dog> listOfDogs = await this.dogs();
    if (listOfDogs.length == 0) {
      print('No Dogs in the list');
    } else {
      listOfDogs.forEach((dog) {
        print('Dog{id: ${dog.id}, name: ${dog.name}, age: ${dog.age}');
      });
    }
  }

  Future<List<Dog>> dogs() async {
    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('dogs');
    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Dog(
        id: maps[i]['id'],
        name: maps[i]['name'],
        age: maps[i]['age'],
      );
    });
  }

  Future<void> updateDog(Dog dog) async {
    // Update the given Dog.
    await db.update(
      'dogs',
      dog.toMap(),
      // Ensure that the Dog has a matching id.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [dog.id],
    );
  }

  Future<void> deleteDog(int id) async {
    // Remove the Dog from the database.
    await db.delete(
      'dogs',
      // Use a `where` clause to delete a specific dog.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }
}
