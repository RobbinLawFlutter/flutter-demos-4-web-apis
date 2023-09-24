// ignore_for_file: avoid_print, library_prefixes, avoid_function_literals_in_foreach_calls

import 'package:path/path.dart' as pathPackage;
import 'package:sqflite/sqflite.dart' as sqflitePackage;
import 'package:robbinlaw/models/model-element.dart';

class SQFliteDbService {
  late sqflitePackage.Database db;
  late String path;

  Future<void> getOrCreateDatabaseHandle() async {
    try {
      var databasesPath = await sqflitePackage.getDatabasesPath();
      path = pathPackage.join(databasesPath, 'app_database.db');
      db = await sqflitePackage.openDatabase(
        path,
        onCreate: (sqflitePackage.Database db1, int version) async {
          await db1.execute(
            "CREATE TABLE AppData(city TEXT PRIMARY KEY, temperature INT, message TEXT, condition TEXT)",
          );
        },
        version: 1,
      );
      print('db = $db');
    } catch (e) {
      print('SQFliteDbService getOrCreateDatabaseHandle CATCH: $e');
    }
  }

  Future<void> printAllRecordsInDbToConsole() async {
    try {
      List<ModelElement> listOfRecords = await getAllRecordsFromDb();
      if (listOfRecords.isEmpty) {
        print('No records in the db');
      } else {
        listOfRecords.forEach((item) {
          print(
              '{city: ${item.city}, temp: ${item.temperature}, message: ${item.message}, condition: ${item.condition}}');
        });
      }
    } catch (e) {
      print('SQFliteDbService printAllRecordsInDbToConsole CATCH: $e');
    }
  }

  Future<List<ModelElement>> getAllRecordsFromDb() async {
    try {
      // Query the table for all The Records.
      // The .query will return a list with each item in the list being a map.
      final List<Map<String, dynamic>> itemMap = await db.query('AppData');
      print('itemMap: $itemMap');
      // Convert the List<Map<String, dynamic> into a List<ModelElement>.
      return List.generate(itemMap.length, (i) {
        return ModelElement(
          city: itemMap[i]['city'],
          temperature: itemMap[i]['temperature'],
          message: itemMap[i]['message'],
          condition: itemMap[i]['condition']
        );
      });
    } catch (e) {
      print('SQFliteDbService getAllRecordsFromDb CATCH: $e');
      return [];
    }
  }

  Future<void> deleteDb() async {
    try {
      await sqflitePackage.deleteDatabase(path);
      print('Db deleted');
      getOrCreateDatabaseHandle();
    } catch (e) {
      print('SQFliteDbService deleteDb CATCH: $e');
    }
  }

  Future<void> insertRecord(ModelElement modelElement) async {
    try {
      await db.insert(
        'AppData',
        modelElement.toMap(),
        conflictAlgorithm: sqflitePackage.ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('SQFliteDbService insertRecord CATCH: $e');
    }
  }

  Future<void> updateRecord(ModelElement modelElement) async {
    try {
      await db.update(
        'AppData',
        modelElement.toMap(),
        where: "city = ?",
        // whereArg prevents SQL injection.
        whereArgs: [modelElement.city],
      );
    } catch (e) {
      print('SQFliteDbService updateRecord CATCH: $e');
    }
  }

  Future<void> deleteRecord(ModelElement modelElement) async {
    try {
      await db.delete(
        'AppData',
        where: "city = ?",
        // whereArg to prevent SQL injection.
        whereArgs: [modelElement.city],
      );
    } catch (e) {
      print('SQFliteDbService deleteRecord CATCH: $e');
    }
  }
}
