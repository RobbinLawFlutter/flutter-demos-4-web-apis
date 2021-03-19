//https://flutter.dev/docs/cookbook/persistence/sqlite
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:get/get.dart';

import 'package:robbinlaw/services/db-service.dart';
import 'package:robbinlaw/models/dog.dart';
import 'package:robbinlaw/models/dog_list.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  SQFliteDbService _databaseService = SQFliteDbService();
  var _dogList = List<Dog>();
  String _dogName = "";

  @override
  void initState() {
    super.initState();
    getOrCreateDbAndDisplayAllDogsInDb();
  }

  void getOrCreateDbAndDisplayAllDogsInDb() async {
    await _databaseService.getOrCreateDatabaseHandle();
    _dogList = await _databaseService.getAllDogsFromDb();
    await _databaseService.printAllDogsInDbToConsole();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('db Demo'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            child: Text(
              'Delete All Records in Database',
            ),
            onPressed: () async {
              _dogList.forEach(
                (dog) async {
                  await _databaseService.deleteDog(dog);
                },
              );
              _dogList = await _databaseService.getAllDogsFromDb();
              await _databaseService.printAllDogsInDbToConsole();
              await _databaseService.deleteDb();
              setState(() {});
            },
          ),
          ElevatedButton(
            child: Text(
              'Add Dog',
            ),
            onPressed: () {
              _addDogToDb();
            },
          ),
          //We must use an Expanded widget to get
          //the dynamic ListView to play nice
          //with the RaisedButtons.
          Expanded(child: DogList(dogs: _dogList)),
        ],
      ),
    );
  }

  Future<Null> _addDogToDb() async {
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Input Dogs Name'),
          contentPadding: EdgeInsets.all(5.0),
          content: TextField(
            decoration: InputDecoration(
              hintText: "Dogs Name",
            ),
            onChanged: (String value) {
              _dogName = value;
            },
          ),
          actions: <Widget>[
            TextButton(
              child: Text("AddDog"),
              onPressed: () async {
                if (_dogName.isNotEmpty) {
                  print('User entered dogName: $_dogName');
                  try {
                    await _databaseService.insertDog(
                        Dog(id: _dogList.length, name: _dogName, age: 5));
                    _dogList = await _databaseService.getAllDogsFromDb();
                    _databaseService.printAllDogsInDbToConsole();
                    setState(() {});
                  } catch (e) {
                    print('HomeView _addDogToDb catch: $e');
                  }
                }
                _dogName = "";
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }
}
