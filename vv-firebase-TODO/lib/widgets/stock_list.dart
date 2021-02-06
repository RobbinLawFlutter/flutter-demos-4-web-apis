// //This module takes in a list and converts it to
// //and then returns a ListView Widget populated with
// //ListTiles.

// //ListView Widget of the Week
// //https://www.youtube.com/watch?v=KJpkjHGiI5A&vl=en

// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:robbinlaw/models/app.dart';

// class StockList extends StatefulWidget {
//   StockList({this.stocks});

//   final List<AppModel> stocks;

//   @override
//   State<StatefulWidget> createState() {
//     return _StockListState();
//   }
// }

// class _StockListState extends State<StockList> {
//   @override
//   Widget build(BuildContext context) {
//     return _buildStockList(context, widget.stocks);
//   }

//   ListView _buildStockList(context, List<AppModel> stocks) {
//     return ListView.builder(
//       itemCount: stocks.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           //TODO:  use title, subtitle, and trailing to display the stock symbol
//           // companyName and latestPrice
//           title: Text('Symbol: ${stocks[index].symbol}'),
//           subtitle: Text('Name: ${stocks[index].name ?? "name not found"}'),
//           trailing:
//               Text('Price: \$${stocks[index].price ?? "price not found"} USD'),
//         );
//       },
//     );
//   }
// }
