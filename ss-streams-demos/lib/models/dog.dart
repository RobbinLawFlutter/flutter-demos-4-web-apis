//This class needs a method to
//create a Map type from class fields.
//This is needed because sqflight stores
//items in the database as Maps.

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
