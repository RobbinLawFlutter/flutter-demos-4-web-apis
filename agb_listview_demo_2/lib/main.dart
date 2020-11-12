import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp(
    items: List<ListItem>.generate(
      20,
      (i) => i % 6 == 0
          ? HeadingItem("Heading $i")
          : MessageItem("Sender $i", "Message body $i"),
    ),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({@required this.items});

  final List<ListItem> items;

  @override
  Widget build(BuildContext context) {
    final title = 'Mixed List';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: ListView.builder(
          // Let the ListView.builder know how many items it needs to build.
          itemCount: items.length,
          // Provide an itemBuilder function. This is where the magic happens.
          // Convert each item into a widget based on the type of item it is.
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
        ),
      ),
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
