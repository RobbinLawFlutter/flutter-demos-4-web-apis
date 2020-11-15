//https://flutter.dev/docs/cookbook/persistence/sqlite

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:path/path.dart' as pathPackage;
import 'package:sqflite/sqflite.dart' as sqflitePackage;

import 'dog.dart';
import 'dog_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final Color themeColor = Color(0xFF808366);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        brightness: Brightness.light,
        accentColor: Colors.black,
        primaryColor: themeColor,
        primaryTextTheme: TextTheme(),
        scaffoldBackgroundColor: themeColor,
        dialogTheme: DialogTheme(
          backgroundColor: Colors.orange[50],
          titleTextStyle: TextStyle(
            color: Colors.orange,
          ),
          contentTextStyle: TextStyle(
            color: Colors.yellow,
          ),
        ),
        indicatorColor: Colors.black,
        textTheme: TextTheme(
          //subtitle1 is for ListTile text color.
          subtitle1: TextStyle(color: Colors.black),
          bodyText1: TextStyle(
            //color: Colors.white,
            fontSize: 36,
          ),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.white,
          textTheme: ButtonTextTheme.primary,
        ),
        iconTheme: IconThemeData(
          //color: Colors.white,
          size: 200,
        ),
        primaryIconTheme: IconThemeData(
            //color: Colors.white,
            ),
      ),
      home: MyDataApp(),
    );
  }
}

class MyDataApp extends StatefulWidget {
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
    getOrCreateDbAndDisplayAllDogsInDb();
  }

  void getOrCreateDbAndDisplayAllDogsInDb() async {
    await databaseHelper.getOrCreateDatabaseHandle();
    _dogList = await databaseHelper.getAllDogsFromDb();
    await databaseHelper.printAllDogsInDb();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('db Demo'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RaisedButton(
            child: Text(
              'Delete All Records in Database',
            ),
            onPressed: () async {
              _dogList.forEach(
                (dog) async {
                  await databaseHelper.deleteDog(dog);
                },
              );
              _dogList = await databaseHelper.getAllDogsFromDb();
              await databaseHelper.printAllDogsInDb();
              setState(() {});
            },
          ),
          RaisedButton(
            child: Text(
              'Add Dog Record to Database',
            ),
            onPressed: () {
              _addDogToDb();
            },
          ),
          //We must use an Expanded widget to get
          //the dynamic ListView to play nice
          //with the RaisedButtons.
          Expanded(child: DogList(dogs: _dogList)),
        ],
      ),
    );
  }

  Future<Null> _addDogToDb() async {
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Input Dogs Name'),
          contentPadding: EdgeInsets.all(5.0),
          content: TextField(
            decoration: InputDecoration(hintText: "Dogs Name"),
            onChanged: (String value) {
              _dogName = value;
            },
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("AddDog"),
              onPressed: () async {
                if (_dogName.isNotEmpty) {
                  await databaseHelper.insertDog(
                      Dog(id: _dogList.length, name: _dogName, age: 5));
                  _dogList = await databaseHelper.getAllDogsFromDb();
                  databaseHelper.printAllDogsInDb();
                  setState(() {
                    //_dogList = await databaseHelper.getAllDogsFromDb();
                    // _dogList
                    //     .add(Dog(id: _dogList.length, name: _dogName, age: 5));
                  });
                }
                _dogName = "";
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }
}

class DatabaseHelper {
  sqflitePackage.Database db;

  Future<void> getOrCreateDatabaseHandle() async {
    var databasesPath = await sqflitePackage.getDatabasesPath();
    print('$databasesPath');
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
    print('$db');
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

  Future<void> printAllDogsInDb() async {
    List<Dog> listOfDogs = await this.getAllDogsFromDb();
    if (listOfDogs.length == 0) {
      print('No Dogs in the list');
    } else {
      listOfDogs.forEach((dog) {
        print('Dog{id: ${dog.id}, name: ${dog.name}, age: ${dog.age}');
      });
    }
  }

  Future<List<Dog>> getAllDogsFromDb() async {
    // Query the table for all The Dogs.
    //The .query will return a list with each item being a map.
    final List<Map<String, dynamic>> dogMap = await db.query('dogs');
    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(dogMap.length, (i) {
      return Dog(
        id: dogMap[i]['id'],
        name: dogMap[i]['name'],
        age: dogMap[i]['age'],
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

  Future<void> deleteDog(Dog dog) async {
    // Remove the Dog from the database.
    await db.delete(
      'dogs',
      // Use a `where` clause to delete a specific dog.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [dog.id],
    );
  }
}
