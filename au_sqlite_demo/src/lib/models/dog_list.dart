import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dog.dart';

class DogList extends StatefulWidget {
  const DogList ({Key? key, required this.dogs}) : super(key: key);

  final List<Dog> dogs;

  @override
  State<StatefulWidget> createState() {
    return _DogListState();
  }
}

class _DogListState extends State<DogList> {
  @override
  Widget build(BuildContext context) {
    return _buildDogList(context, widget.dogs);
  }

  ListView _buildDogList(context, List<Dog> dogs) {
    return ListView.builder(
      itemCount: dogs.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text('name: ${dogs[index].name}'),
            subtitle: Text('id: ${dogs[index].id}'),
            trailing: Text('age: ${dogs[index].age}'),
          ),
        );
      },
    );
  }
}
