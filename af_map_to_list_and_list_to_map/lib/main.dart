class Customer {
  Customer(this.name, this.age);
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
    return '{ ${this.name}, ${this.age} }';
  }
}

main() {
  // //Creating a list of Customer objects.
  List listOfCustomerObjects1 = [];
  listOfCustomerObjects1.add(Customer('Jack', 23));
  listOfCustomerObjects1.add(Customer('Adam', 27));
  listOfCustomerObjects1.add(Customer('Katherin', 25));
  //Convert the List<Customer> into a List<Map<String, dynamic>>
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
  // Convert the List<Map<String, dynamic>> into a List<Customer>.
  var listOfCustomerObjects2 = List.generate(listOfMaps2.length, (i) {
    return Customer(
      listOfMaps2[i]['name'],
      listOfMaps2[i]['age'],
    );
  });
  print('listOfCustomerObjects2= $listOfCustomerObjects2');
}
