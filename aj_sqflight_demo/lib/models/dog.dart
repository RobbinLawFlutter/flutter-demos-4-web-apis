//This class needs a toMap method to
//convert a list to a map.

class Dog {
  Dog({this.id, this.name, this.age});

  final int id;
  final String name;
  final int age;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }
}
