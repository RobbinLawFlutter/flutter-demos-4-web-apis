import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:robbinlaw/controllers/appController.dart';
import 'package:robbinlaw/widgets/numberCard.dart';

class NumbersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<AppController>(
      builder: (_) {
        print('NumbersList GetX<AppController> builder:');
        return Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            padding: EdgeInsets.all(6.0),
            children: _.numberType.map((numberModel) {
              return NumberCard(
                numberModel: numberModel,
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
