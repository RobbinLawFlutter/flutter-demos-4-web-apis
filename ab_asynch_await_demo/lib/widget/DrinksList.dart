import 'package:coffee_store_app/widget/DrinksCard.dart';
import 'package:flutter/material.dart';

class DrinksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      //GridView children must be a list of widgets.
      child: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(6.0),
        //coffeeTypes is a list of DrinkType objects.
        //DrinkType is a class with properties, title, image file name, price.
        //We transform the coffeTypes list into a new
        //list of DrinksCards using each of coffeTypes DrinkType
        //object data.
        //We use the List.map().toList()
        //method calls from the List class to do this.
        children: coffeeTypes.map((e) {
          return DrinksCard(
            drinkType: e,
          );
        }).toList(),
      ),
    );
  }
}
