//This module takes in a list and converts it to
//a ListView Widget populated with
//Cards made with ListTiles.

//ListView Widget of the Week
//https://www.youtube.com/watch?v=KJpkjHGiI5A&vl=en

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:robbinlaw/models/stock.dart';

class StockList extends StatefulWidget {
  StockList({required this.stocks});

  final List<Stock> stocks;

  @override
  State<StatefulWidget> createState() {
    return _StockListState();
  }
}

class _StockListState extends State<StockList> {
  @override
  Widget build(BuildContext context) {
    return _buildStockList(context, widget.stocks);
  }

  ListView _buildStockList(context, List<Stock> stocks) {
    return ListView.builder(
      itemCount: stocks.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title:
              Text('Symbol: ${stocks[index].symbol}'),
            //TODO:  
            //Use subtitle, and trailing properties of ListTile
            //to display the companyName, and latestPrice.
            subtitle: 
              Text('Name: ${stocks[index].name}'),
            trailing: 
              Text('Price: \$${stocks[index].price} USD'),
          ),
        );
      },
    );
  }
}
