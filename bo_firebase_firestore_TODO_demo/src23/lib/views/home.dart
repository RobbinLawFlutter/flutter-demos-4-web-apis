// ignore_for_file: use_key_in_widget_constructors, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print('Home build:');
    return Scaffold(
      appBar: AppBar(
        title: Text('user: ${Authorization().currentUser?.displayName}'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () async {
              try {
                await Authorization().logOut();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    duration: Duration(seconds: 1),
                    content: Text('logged out'),
                  ),
                );
              } catch (e) {
                print('Home: CATCH $e');
              }
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
                      try {
                        if (textEditingController.text != "") {
                          Database().addAppData(textEditingController.text,
                              Authorization().currentUser!.uid);
                          textEditingController.clear();
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(seconds: 1),
                            content: Text('todo added'),
                          ),
                        );
                      } catch (e) {
                        print('Home: CATCH $e');
                      }
                    },
                  )
                ],
              ),
            ),
          ),
          const Text(
            "Your Todos",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          StreamBuilder(
              stream: Database().streamOfAppData(Authorization().currentUser!.uid),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.data == null) {
                  print('no data yet');
                  return const LinearProgressIndicator();
                }
                var listOfDocs = snapshot.data!.docs;
                return Expanded(
                  child: ListView.builder(
                      itemCount: listOfDocs.length,
                      itemBuilder: (BuildContext context, index) {
                        var doc = listOfDocs[index];
                        if (useDissmissible) {
                          return MyCardWithDismissible(
                            userId: Authorization().currentUser!.uid,
                            document: doc,
                          );
                        } else {
                          return MyCardWithSlidable(
                            userId: Authorization().currentUser!.uid,
                            document: doc,
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
