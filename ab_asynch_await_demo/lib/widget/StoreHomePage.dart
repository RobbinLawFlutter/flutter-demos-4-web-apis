import 'package:coffee_store_app/widget/DrinksCarousel.dart';
import 'package:coffee_store_app/widget/DrinksList.dart';
import 'package:flutter/material.dart';

class MyApp3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App3',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StoreHomePage(title: 'App3 Tab Controls with ScopedModel'),
    );
  }
}

class StoreHomePage extends StatelessWidget {
  const StoreHomePage({this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: <Widget>[
          DrinksCarousel(),
          DrinksList(),
        ],
      ),
    );
  }
}
