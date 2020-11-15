import 'package:path/path.dart' as pathPackage;
import 'package:sqflite/sqflite.dart' as sqflitePackage;

import 'package:sqflight_demo/models/dog.dart';

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
