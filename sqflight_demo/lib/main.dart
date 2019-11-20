import 'package:flutter/material.dart';
import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() => runApp(MyDataApp());

class MyDataApp extends StatefulWidget {
  @override
  _MyDataAppState createState() => _MyDataAppState();
}

class _MyDataAppState extends State<MyDataApp> {
  DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    runTheCode();
  }

  void runTheCode() async {
    await databaseHelper.getOrCreateDatabaseHandle();

    var fido = Dog(
      id: 0,
      name: 'Fido',
      age: 35,
    );

    await databaseHelper.insertDog(fido);

    databaseHelper.printDogs();

    fido = Dog(
      id: fido.id,
      name: fido.name,
      age: fido.age + 7,
    );

    await databaseHelper.updateDog(fido);

    databaseHelper.printDogs();

    await databaseHelper.deleteDog(fido.id);

    databaseHelper.printDogs();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Dog {
  final int id;
  final String name;
  final int age;

  Dog({this.id, this.name, this.age});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }
}

class DatabaseHelper {
  Database db;

  Future<void> getOrCreateDatabaseHandle() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, 'doggie_database.db');
    print('$path');
    db = await openDatabase(
      path,
      onCreate: (Database db1, int version) async {
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
      conflictAlgorithm: ConflictAlgorithm.replace,
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

// Implement toString to make it easier to see information about
  // each dog when using the print statement.
  //@override
  //String toString() {
  //return 'Dog{id: $id, name: $name, age: $age}';
  //}

  Future<void> updateDog(Dog dog) async {
    // Get a reference to the database.
    //final Database db = await database;

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
    // Get a reference to the database.
    //final Database db = await database;

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
