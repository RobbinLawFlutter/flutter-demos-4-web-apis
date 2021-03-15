import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:robbinlaw/models/numberTypes.dart';
import 'package:robbinlaw/models/numberModel.dart';
import 'package:robbinlaw/controllers/appController.dart';
import 'package:robbinlaw/widgets/numbersCarousel.dart';
import 'package:robbinlaw/widgets/numbersList.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NUMBERS Demo'),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              const PopupMenuItem(
                  value: 1, child: Text('Show ones in gridview')),
              const PopupMenuDivider(),
              const PopupMenuItem(
                  value: 2, child: Text('Show twos in gridview')),
              const PopupMenuDivider(),
              const PopupMenuItem(
                  value: 3, child: Text('Show threes in gridview')),
            ],
            onCanceled: () {
              print("You have canceled the menu.");
            },
            onSelected: (value) {
              print("top right value:$value");
              List<NumberModel> numberListType;
              switch (value) {
                case 1:
                  numberListType = oneTypes;
                  break;
                case 2:
                  numberListType = twoTypes;
                  break;
                case 3:
                  numberListType = threeTypes;
                  break;
                default:
                  throw '$value not recognized';
              }
              Get.find<AppController>().updateNumberListType(numberListType);
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          NumbersCarousel(),
          NumbersList(),
        ],
      ),
    );
  }
}
