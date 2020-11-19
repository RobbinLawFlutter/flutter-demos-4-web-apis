// Map map = {'name': 'Jack', 'age': 23};
//   //Map map0 = {'name': 'Jack', 'age': 27};
//   var list1 = [];
//   //Convert a map to a list of Customer objects.
//   map.forEach((k, v) => list1.add(Customer(k, v)));
//   print('list1= $list1');
//   //Another way to convert a map to a list of Customer objects.
//   var list2 = [];
//   map.entries.forEach((e) => list2.add(Customer(e.key, e.value)));
//   print('list2= $list2');
//   //Another way to convert a map to a list of Customer objects.
//   //We convert the map into a view and then to a list.
//   var list3 = [];
//   list3 = map.entries.map((e) => Customer(e.key, e.value)).toList();
//   print('list3= $list3');

// //Creating a list of Customer objects.
//   List list4 = [];
//   list4.add(Customer('Jack', 23));
//   list4.add(Customer('Adam', 27));
//   list4.add(Customer('Katherin', 25));
//   //Converting a list to a map.
//   var map1 = Map.fromIterable(list4, key: (e) => e.name, value: (e) => e.age);
//   print('map1= $map1');
//   //Another way to convert a list to a map.
//   var map2 = {};
//   list4.forEach((customer) => map2[customer.name] = customer.age);
//   print('map2= $map2');
//   //Creating a view from a list.
//   //Notice the data in this view is completely
//   //different from anything in the list.
//   var view1 = list4.map((e) => 'hey');
//   print('view1= $view1');
