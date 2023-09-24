import 'package:path/path.dart' as pathPackage;
import 'package:sqflite/sqflite.dart' as sqflitePackage;
import 'package:robbinlaw/models/stock.dart';

class SQFliteDbService {
  late sqflitePackage.Database db;
  late String path;

  Future<void> getOrCreateDatabaseHandle() async {
    try {
      var databasesPath = await sqflitePackage.getDatabasesPath();
      path = pathPackage.join(databasesPath, 'stocks_database.db');
      db = await sqflitePackage.openDatabase(
        path,
        onCreate: (sqflitePackage.Database db1, int version) async {
          await db1.execute(
            "CREATE TABLE stocks(symbol TEXT PRIMARY KEY, name TEXT, price REAL)",
          );
        },
        version: 1,
      );
      print('db = $db');
    } catch (e) {
      print('SQFliteDbService getOrCreateDatabaseHandle: $e');
    }
  }

  Future<void> printAllStocksInDbToConsole() async {
    try {
      List<Stock> listOfStocks = await this.getAllStocksFromDb();
      if (listOfStocks.length == 0) {
        print('No Stocks in the list');
      } else {
        listOfStocks.forEach((stock) {
          print(
              'Stock{symbol: ${stock.symbol}, name: ${stock.name}, price: ${stock.price}}');
        });
      }
    } catch (e) {
      print('SQFliteDbService printAllStocksInDbToConsole: $e');
    }
  }

  Future<List<Stock>> getAllStocksFromDb() async {
    try {
      // Query the table for all The Stocks.
      //The .query will return a list with each item in the list being a map.
      final List<Map<String, dynamic>> stockMap = await db.query('stocks');
      // Convert the List<Map<String, dynamic> into a List<Stock>.
      return List.generate(stockMap.length, (i) {
        return Stock(
          symbol: stockMap[i]['symbol'],
          name: stockMap[i]['name'],
          price: stockMap[i]['price'],
        );
      });
    } catch (e) {
      print('SQFliteDbService getAllStocksFromDb: $e');
      return [];
    }
  }

  Future<void> deleteDb() async {
    try {
      await sqflitePackage.deleteDatabase(path);
      //db = null;
      print('Db deleted');
      getOrCreateDatabaseHandle();
    } catch (e) {
      print('SQFliteDbService deleteDb: $e');
    }
  }

  Future<void> insertStock(Stock stock) async {
    try {
      //TODO: 
      //Put code here to insert a stock into the database.
      //Insert the Stock into the correct table. 
      //Also specify the conflictAlgorithm. 
      //In this case, if the same stock is inserted
      //multiple times, it replaces the previous data.
      await db.insert(
        'stocks',
        stock.toMap(),
        conflictAlgorithm: sqflitePackage.ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('SQFliteDbService insertStock: $e');
    }
  }

  Future<void> updateStock(Stock stock) async {
    try {
      //TODO: 
      //Put code here to update stock info.
      await db.update(
        'stocks',
        stock.toMap(),
        // Ensure that the Stock has a matching symbol.
        where: "symbol = ?",
        // Pass the Stock's symbol as a whereArg to prevent SQL injection.
        whereArgs: [stock.symbol],
      );
    } catch (e) {
      print('SQFliteDbService updateStock: $e');
    }
  }

  Future<void> deleteStock(Stock stock) async {
    try {
      //TODO: 
      //Put code here to delete a stock from the database.
      await db.delete(
        'stocks',
        // Use a `where` clause to delete a specific stock.
        where: "symbol = ?",
        // Pass the Stock's symbol as a whereArg to prevent SQL injection.
        whereArgs: [stock.symbol],
      );
    } catch (e) {
      print('SQFliteDbService deleteStock: $e');
    }
  }
}
