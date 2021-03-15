import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:robbinlaw/models/numberModel.dart';
import 'package:robbinlaw/models/numberTypes.dart';
import 'package:robbinlaw/widgets/numberCard.dart';
import 'package:robbinlaw/controllers/appController.dart';

class NumbersCarousel extends StatefulWidget {
  @override
  _NumbersCarouselState createState() => _NumbersCarouselState();
}

class _NumbersCarouselState extends State<NumbersCarousel>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: mainTypes.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350.0,
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            width: 4.0,
            color: Colors.black45,
          ),
        ),
        child: Stack(
          children: <Widget>[
            TabBarView(
              controller: _tabController,
              children: mainTypes.map((numberModel) {
                return GestureDetector(
                  onTap: () {
                    print('You chose the type ${numberModel.type}');
                  },
                  child: NumberCard(
                    numberModel: numberModel,
                  ),
                );
              }).toList(),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: TabPageSelector(
                    controller: _tabController,
                    selectedColor: Colors.white,
                    indicatorSize: 15,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    size: 36,
                  ),
                  onPressed: () {
                    _changeImage(
                      delta: -1,
                    );
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_forward,
                    size: 36,
                  ),
                  onPressed: () {
                    _changeImage(
                      delta: 1,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _changeImage({int delta}) {
    var newTabIndex = _tabController.index + delta;
    if (newTabIndex >= mainTypes.length) {
      newTabIndex = 0;
    } else if (newTabIndex < 0) {
      newTabIndex = mainTypes.length - 1;
    }
    _tabController.animateTo(
      newTabIndex,
    );
  }
}
