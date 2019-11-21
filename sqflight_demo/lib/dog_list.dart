import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dog.dart';

class DogList extends StatefulWidget {
  DogList({Key key, this.dogs}) : super(key: key);

  final List<Dog> dogs;

  @override
  State<StatefulWidget> createState() {
    return new _DogListState();
  }
}

class _DogListState extends State<DogList> {
  @override
  Widget build(BuildContext context) {
    return _buildDogList(context, widget.dogs);
  }

  ListView _buildDogList(context, List<Dog> dogs) {
    return new ListView.builder(
      itemCount: dogs.length,
      itemBuilder: (context, index) {
        return ListTile(
            title: Text('name: ${dogs[index].name ?? "name not found"}'),
            trailing: Text('age: ${dogs[index].age ?? "age not found"}'),
            subtitle: Text('id: ${dogs[index].id ?? "id not found"}'));
      },
    );
  }
}
