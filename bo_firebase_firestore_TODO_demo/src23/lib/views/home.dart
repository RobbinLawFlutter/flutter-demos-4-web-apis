// ignore_for_file: use_key_in_widget_constructors, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:robbinlaw/services/authorization.dart';
import 'package:robbinlaw/services/database.dart';
import 'package:robbinlaw/widgets/mycard.dart';
import 'package:robbinlaw/views/login.dart';
import 'package:robbinlaw/views/signup.dart';

class Home extends StatelessWidget {
  final Authorization auth = Authorization();
  final TextEditingController _textEditingController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    print('Home build:');
    return Scaffold(
      appBar: AppBar(
        title: Text('user: ${auth.authInst.currentUser?.uid}'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () async {
              bool status = await auth.logOut();
              if (status) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      ),
                    );
                  }
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
                      controller: _textEditingController,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      print('Home +Icon onPressed:');
                      if (_textEditingController.text != "") {
                        Database().addAppData(
                            _textEditingController.text, auth.authInst.currentUser?.uid);
                        _textEditingController.clear();
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
          // StreamBuilder(
          //   stream: Database().streamOfAppData(auth.currentUserUid),
          //   builder: (){Center(child: Text('fun'),)},
          // ),
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: _.appList.length,
          //     itemBuilder: (__, index) {
          //       return MyCardWithDismissible(
          //           key: const ValueKey(0),
          //           userId: auth.currentUserUid,
          //           appModel: _.appList[index]);
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
