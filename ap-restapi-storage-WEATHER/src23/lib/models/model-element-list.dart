//This module takes in a list and converts it to
//a ListView Widget populated with
//Cards made with ListTiles.

//ListView Widget of the Week
//https://www.youtube.com/watch?v=KJpkjHGiI5A&vl=en

// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:robbinlaw/models/model-element.dart';

class ModelElementList extends StatefulWidget {
  ModelElementList({required this.modelElements});

  final List<ModelElement> modelElements;

  @override
  State<StatefulWidget> createState() {
    return _ModelElementListState();
  }
}

class _ModelElementListState extends State<ModelElementList> {
  @override
  Widget build(BuildContext context) {
    return _buildList(context, widget.modelElements);
  }

  ListView _buildList(context, List<ModelElement> modelElementList) {
    return ListView.builder(
      itemCount: modelElementList.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title:
              Text('${modelElementList[index].city}: ${modelElementList[index].temperature} degC'),
            subtitle: 
              Text('${modelElementList[index].message} '),
            trailing: 
              Text('${modelElementList[index].condition} '),
          ),
        );
      },
    );
  }
}
