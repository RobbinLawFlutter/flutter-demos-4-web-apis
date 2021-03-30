//https://flutter.dev/docs/cookbook/persistence/sqlite

//sqflite package of the week.
//https://www.youtube.com/watch?v=HefHf5B1YM0&vl=en

import 'package:path/path.dart' as pathPackage;
import 'package:sqflite/sqflite.dart' as sqflitePackage;

import 'package:robbinlaw/models/dog.dart';

class SQFliteDbService {
  sqflitePackage.Database db;
  String path;

  Future<void> getOrCreateDatabaseHandle() async {
    try {
      var databasesPath = await sqflitePackage.getDatabasesPath();
      path = pathPackage.join(databasesPath, 'doggie_database.db');
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
    } catch (e) {
      print('SQFliteDbService getOrCreateDatabaseHandle: $e');
    }
  }

  Future<void> printAllDogsInDbToConsole() async {
    try {
      List<Dog> listOfDogs = await this.getAllDogsFromDb();
      if (listOfDogs.length == 0) {
        print('No Dogs in the list');
      } else {
        listOfDogs.forEach((dog) {
          print('Dog{id: ${dog.id}, name: ${dog.name}, age: ${dog.age}');
        });
      }
    } catch (e) {
      print('SQFliteDbService printAllDogsInDbToConsole: $e');
    }
  }

  Future<List<Dog>> getAllDogsFromDb() async {
    try {
      // Query the table for all The Dogs.
      //The .query will return a list with each item in the list being a map.
      final List<Map<String, dynamic>> dogMap = await db.query('dogs');
      // Convert the List<Map<String, dynamic> into a List<Dog>.
      return List.generate(dogMap.length, (i) {
        return Dog(
          id: dogMap[i]['id'],
          name: dogMap[i]['name'],
          age: dogMap[i]['age'],
        );
      });
    } catch (e) {
      print('SQFliteDbService getAllDogsFromDb: $e');
      return null;
    }
  }

  Future<void> deleteDb() async {
    try {
      await sqflitePackage.deleteDatabase(path);
      db = null;
      print('Db deleted');
      getOrCreateDatabaseHandle();
    } catch (e) {
      print('SQFliteDbService deleteDb: $e');
    }
  }

  Future<void> insertDog(Dog dog) async {
    try {
      // Insert the Dog into the correct table. Also specify the
      // `conflictAlgorithm`. In this case, if the same dog is inserted
      // multiple times, it replaces the previous data.
      await db.insert(
        'dogs',
        dog.toMap(),
        //conflictAlgorithm: sqflitePackage.ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('SQFliteDbService insertDog: $e');
    }
  }

  Future<void> updateDog(Dog dog) async {
    try {
      // Update the given Dog.
      await db.update(
        'dogs',
        dog.toMap(),
        // Ensure that the Dog has a matching id.
        where: "id = ?",
        // Pass the Dog's id as a whereArg to prevent SQL injection.
        whereArgs: [dog.id],
      );
    } catch (e) {
      print('SQFliteDbService updateDog: $e');
    }
  }

  Future<void> deleteDog(Dog dog) async {
    try {
      // Remove the Dog from the database.
      await db.delete(
        'dogs',
        // Use a `where` clause to delete a specific dog.
        where: "id = ?",
        // Pass the Dog's id as a whereArg to prevent SQL injection.
        whereArgs: [dog.id],
      );
    } catch (e) {
      print('SQFliteDbService deleteDog: $e');
    }
  }
}
