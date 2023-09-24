// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:robbinlaw/models/stock-list.dart';
import 'package:robbinlaw/models/stock.dart';
import 'package:robbinlaw/services/stock-service.dart';
import 'package:robbinlaw/services/db-service.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final StockService _stockService = StockService();
  final SQFliteDbService _databaseService = SQFliteDbService();
  var _stockList = <Stock>[];
  String _stockSymbol = "";

  @override
  void initState() {
    super.initState();
    getOrCreateDbAndDisplayAllStocksInDb();
  }

  void getOrCreateDbAndDisplayAllStocksInDb() async {
    await _databaseService.getOrCreateDatabaseHandle();
    _stockList = await _databaseService.getAllStocksFromDb();
    await _databaseService.printAllStocksInDbToConsole();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App 4 Stock Ticker'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            child: const Text(
              'Delete All Records and Db',
            ),
            onPressed: () async {
              _stockList.forEach(
                (e) async {
                  await _databaseService.deleteStock(e);
                },
              );
              _stockList = await _databaseService.getAllStocksFromDb();
              await _databaseService.printAllStocksInDbToConsole();
              await _databaseService.deleteDb();
              setState(() {});
            },
          ),
          ElevatedButton(
            child: const Text(
              'Add Stock',
            ),
            onPressed: () {
              _inputStock();
            },
          ),
          //We must use an Expanded widget to get
          //the dynamic ListView to play nice
          //with the TextButton.
          //StockList(stocks: _stockList),
          Expanded(child: StockList(stocks: _stockList)),
        ],
      ),
    );
  }

  Future<Null> _inputStock() async {
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Input Stock Symbol'),
            contentPadding: EdgeInsets.all(5.0),
            content: TextField(
              decoration: InputDecoration(hintText: "Symbol"),
              onChanged: (String value) {
                _stockSymbol = value;
              },
            ),
            actions: <Widget>[
              TextButton(
                child: const Text("Add Stock"),
                onPressed: () async {
                  if (_stockSymbol.isNotEmpty) {
                    print('User entered Symbol: $_stockSymbol');
                    try {
                      //TODO: 
                      //Inside of this try,
                      //get the stock data with _stockService.getQuote
                      //but remember you must use await,
                      //then if it is not null,
                      //dig out the symbol, companyName, and latestPrice,
                      //then create a new object of
                      //type Stock and add it to
                      //the database by calling
                      //_databaseService.insertStock,
                      //then get all the stocks from
                      //the database with
                      //_databaseService.getAllStocksFromDb and
                      //attach them to _stockList,
                      //then print all stocks to the console and,
                      //finally call setstate at the end.
                      var stockData =
                          await _stockService.getQuote(_stockSymbol);
                      if (stockData == null) {
                        print("Call to getQuote failed to return stock data");
                      } else {
                        var symbol = stockData['symbol'];
                        var companyName = stockData['companyName'];
                        print('Symbol = $symbol, Name = $companyName');
                        num price = (stockData['latestPrice']);
                        print(
                            'Price = $price, PriceType = ${price.runtimeType}');
                        await _databaseService.insertStock(Stock(
                            symbol: symbol, name: companyName, price: price));
                        _stockList =
                            await _databaseService.getAllStocksFromDb();
                        _databaseService.printAllStocksInDbToConsole();
                        setState(() {});
                      }
                    } catch (e) {
                      print('HomeView _inputStock catch: $e');
                    }
                  }
                  _stockSymbol = "";
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: const Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }
}
