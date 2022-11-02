// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class CustomerOne {
  CustomerOne(this.name, this.age);
  String name;
  int age;

  @override
  String toString() {
    return '{ $name, $age }';
  }
}

class CustomerTwo {
  CustomerTwo({required this.name, required this.age});
  String name;
  int age;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
    };
  }

  @override
  String toString() {
    return '{ $name, $age }';
  }
}

class Demo2 extends StatelessWidget {
  const Demo2 ({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo2-MapToList and ListToMap Con'),
      ),
      body: const MyDemo(),
    );
  }
}

class MyDemo extends StatefulWidget {
  const MyDemo ({Key? key}) : super(key: key);
  @override
  MyDemoState createState() => MyDemoState();
}

class MyDemoState extends State<MyDemo> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text('Press'),
        onPressed: () {
          performTasks();
        },
      ),
    );
  }
}

void performTasks() {
  Map map = {'Jack': 23, 'Adam': 27, 'Katherin': 25};
  //Map map0 = {'name': 'Jack', 'age': 27};
  var list1 = [];
  //Convert a map to a list of CustomerOne objects.
  map.forEach((k, v) => list1.add(CustomerOne(k, v)));
  print('list1= $list1');
  //Another way to convert a map to a list of CustomerOne objects.
  //We convert the map into a view and then to a list.
  var list3 = [];
  list3 = map.entries.map((e) => CustomerOne(e.key, e.value)).toList();
  print('list3= $list3');

  //Using CustomerOne
  //Creating a list of CustomerOne objects.
  List list4 = [];
  list4.add(CustomerOne('Jack', 23));
  list4.add(CustomerOne('Adam', 27));
  list4.add(CustomerOne('Katherin', 25));

  //Creating a list of maps.
  List<Map<String, dynamic>> myListOfMaps = [
    {'name': 'Jack', 'age': 23},
    {'name': 'Adam', 'age': 27},
    {'name': 'katie', 'age': 25},
  ];
  // Convert the List<Map<String, dynamic> into a List<CustomerOne>.
  var list5 = List.generate(myListOfMaps.length, (i) {
    return CustomerOne(
      myListOfMaps[i]['name'],
      myListOfMaps[i]['age'],
    );
  });
  print('list5= $list5');

  //Using CustomerTwo
  //Creating a list of CustomerTwo objects.
  List listOfCustomerObjects1 = [];
  listOfCustomerObjects1.add(CustomerTwo(name: 'Jack', age: 23));
  listOfCustomerObjects1.add(CustomerTwo(name: 'Adam', age: 27));
  listOfCustomerObjects1.add(CustomerTwo(name: 'Katherin', age: 25));

  //Convert the List<CustomerTwo> into a List<Map<String, dynamic>>
  var listOfMaps1 = List.generate(listOfCustomerObjects1.length, (i) {
    return listOfCustomerObjects1[i].toMap();
  });
  print('listOfMaps1= $listOfMaps1');

  //Creating a list of maps.
  List<Map<String, dynamic>> listOfMaps2 = [
    {'name': 'Jack', 'age': 23},
    {'name': 'Adam', 'age': 27},
    {'name': 'katie', 'age': 25},
  ];
  // Convert the List<Map<String, dynamic>> into a List<CustomerTWo>.
  var listOfCustomerObjects2 = List.generate(listOfMaps2.length, (i) {
    return CustomerTwo(
      name: listOfMaps2[i]['name'],
      age: listOfMaps2[i]['age'],
    );
  });
  print('listOfCustomerObjects2= $listOfCustomerObjects2');
}
