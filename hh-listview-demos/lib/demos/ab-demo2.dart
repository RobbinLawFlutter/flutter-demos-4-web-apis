import 'package:flutter/material.dart';

class Demo2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo2'),
      ),
      body: MyDemo(),
    );
  }
}

class MyDemo extends StatefulWidget {
  @override
  _MyDemoState createState() => _MyDemoState();
}

class _MyDemoState extends State<MyDemo> {
  List<ListItem> items;

  @override
  Widget build(BuildContext context) {
    items = List<ListItem>.generate(
      20,
      (i) => i % 6 == 0
          ? HeadingItem("Heading $i")
          : MessageItem("Sender $i", "Message body $i"),
    );

    return ListView.builder(
      // Let the ListView.builder know how many items it needs to build.
      itemCount: items.length,
      // Provide an itemBuilder function. This is where the magic happens.
      // Convert each item in the list
      //into a widget based on the type of item it is.
      itemBuilder: (context, index) {
        final item = items[index];

        if (item is HeadingItem) {
          return ListTile(
            title: Text(
              item.heading,
              style: Theme.of(context).textTheme.headline4,
            ),
          );
        } else if (item is MessageItem) {
          return ListTile(
            title: Text(item.sender),
            subtitle: Text(item.body),
          );
        }
      },
    );
  }
}

// The base class for the different types of items the list can contain.
abstract class ListItem {}

// A ListItem that contains data to display a heading.
class HeadingItem implements ListItem {
  HeadingItem(this.heading);

  final String heading;
}

// A ListItem that contains data to display a message.
class MessageItem implements ListItem {
  MessageItem(this.sender, this.body);

  final String sender;
  final String body;
}
