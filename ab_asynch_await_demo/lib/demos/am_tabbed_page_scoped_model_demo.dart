//This app demonstrates a working carousel and GridView.
//It also shows property explicit getters and setters.
//Also how to pass parms down the stateful widget tree.
//Also basic exception throwing.

//Dart getters and setters by geekforgeeks.
//https://www.geeksforgeeks.org/getter-and-setter-methods-in-dart/

//Dart getters and setters by dart.dev.
//https://dart.dev/guides/language/language-tour#getters-and-setters

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class MyTabbedScopedModelDemo extends StatelessWidget {
  const MyTabbedScopedModelDemo({this.title, this.color});

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    //ScopedModel is the top level widget of this
    //state management package. Notice it is a generic
    //that is of type MyModel implemented later in this file.
    return ScopedModel<MyModel>(
      //The ScopedModel widgets model property
      //will instanciate an object from MyModel class.
      model: MyModel(),
      child: Scaffold(
        //backgroundColor: color,
        appBar: AppBar(
          title: Text(title),
        ),
        body: Column(
          children: <Widget>[
            NumbersCarousel(color: color),
            NumbersList(),
          ],
        ),
      ),
    );
  }
}

class Number {
  //Constructor
  Number(this.title, this.image);
  //Public fields.
  final String title;
  final String image;
}

List<Number> nums = <Number>[
  Number('1', 'assets/img/1-1.jpg'),
  Number('2', 'assets/img/2-1.jpg'),
];

List<Number> ones = <Number>[
  Number('1-2', 'assets/img/1-2.jpg'),
  Number('1-3', 'assets/img/1-3.jpg'),
  Number('1-4', 'assets/img/1-4.jpg'),
  Number('1-5', 'assets/img/1-5.jpg'),
  Number('1-6', 'assets/img/1-1.jpg'),
  //Number('1-7', 'assets/img/1-7.jpg'),
  //Number('1-8', 'assets/img/1-8.jpg'),
];

List<Number> twos = <Number>[
  Number('2-2', 'assets/img/2-2.jpg'),
  Number('2-3', 'assets/img/2-3.jpg'),
  Number('2-4', 'assets/img/2-4.jpg'),
];

class MyModel extends Model {
  //This is a private field.
  List<Number> _chosenNumberList = ones;
  //This is a public properties getter.
  List<Number> get chosenNumberList => _chosenNumberList;
  //This is a public properties setter.
  set chosenNumberList(List<Number> myChosenNumberList) {
    _chosenNumberList = myChosenNumberList;
    //This is called whenever something is changed.
    notifyListeners();
  }
}

class NumbersCard extends StatelessWidget {
  const NumbersCard({this.instantsNumber});

  final Number instantsNumber;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: Image.asset(
          instantsNumber.image,
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class NumbersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MyModel>(
      builder: (context, child, model) {
        return Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            padding: EdgeInsets.all(6.0),
            children: model.chosenNumberList.map((e) {
              return NumbersCard(
                instantsNumber: e,
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class NumbersCarousel extends StatefulWidget {
  NumbersCarousel({this.color});

  final Color color;

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
      length: nums.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  void _changeImage({int delta}) {
    var newTabIndex = _tabController.index + delta;
    if (newTabIndex >= nums.length) {
      newTabIndex = 0;
    } else if (newTabIndex < 0) {
      newTabIndex = nums.length - 1;
    }
    _tabController.animateTo(
      newTabIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    Color myColor = widget.color;

    return SizedBox(
      height: 350.0,
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            width: 4.0,
            color: myColor,
          ),
        ),
        child: Stack(
          children: <Widget>[
            ScopedModelDescendant<MyModel>(
              //rebuildOnChange: false,
              builder: (context, child, myModel) {
                return TabBarView(
                  controller: _tabController,
                  children: nums.map((e) {
                    return GestureDetector(
                      onTap: () {
                        List<Number> myChosenNumberList;
                        switch (e.title) {
                          case '1':
                            myChosenNumberList = ones;
                            break;
                          case '2':
                            myChosenNumberList = twos;
                            break;
                          default:
                            throw '${e.title} type not recognized';
                        }
                        //This calls the setter of model.chosenNumberList.
                        //type is automatically passed as an argument
                        //into the properties parm.
                        //This happens because of the key word set.
                        myModel.chosenNumberList = myChosenNumberList;
                      },
                      child: NumbersCard(
                        instantsNumber: e,
                      ),
                    );
                  }).toList(),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TabPageSelector(
                  controller: _tabController,
                  color: Colors.white,
                  selectedColor: myColor,
                  indicatorSize: 20,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: myColor,
                  size: 36,
                ),
                onPressed: () {
                  _changeImage(delta: -1);
                },
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_forward,
                  color: myColor,
                  size: 36,
                ),
                onPressed: () {
                  _changeImage(delta: 1);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
