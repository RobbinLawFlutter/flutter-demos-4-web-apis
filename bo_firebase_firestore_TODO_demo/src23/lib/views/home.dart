// ignore_for_file: use_key_in_widget_constructors, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:robbinlaw/models/app.dart';
import 'package:robbinlaw/services/authorization.dart';
import 'package:robbinlaw/services/database.dart';
import 'package:robbinlaw/widgets/mycard.dart';
import 'package:robbinlaw/views/root.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final bool useDissmissible = false;
  final Auth auth = Auth();
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print('Home build:');
    return Scaffold(
      appBar: AppBar(
        title: Text('user: ${auth.currentUser?.displayName}'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () async {
              await auth.logOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Root(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Add Todo Here:",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Card(
            margin: const EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: textEditingController,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      print('Home +Icon onPressed:');
                      if (textEditingController.text != "") {
                        Database().addAppData(
                            textEditingController.text, auth.currentUser!.uid);
                        textEditingController.clear();
                      }
                    },
                  )
                ],
              ),
            ),
          ),
          const Text(
            "Your Todos as a stream",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          StreamBuilder(
              stream: Database().streamOfAppData(auth.currentUser!.uid),
              builder: (BuildContext context,
                  AsyncSnapshot<List<AppModel>> snapshot) {
                if (!snapshot.hasData) {
                  print('no data yet');
                  return const LinearProgressIndicator();
                }
                return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, index) {
                        if (useDissmissible) {
                          return MyCardWithDismissible(
                            key: const ValueKey(0),
                            userId: auth.currentUser!.uid,
                            appModel: snapshot.data![index],
                          );
                        } else {
                          return MyCardWithSlidable(
                            key: const ValueKey(0),
                            userId: auth.currentUser!.uid,
                            appModel: snapshot.data![index],
                          );
                        }
                      }),
                );
              }),
        ],
      ),
    );
  }
}
