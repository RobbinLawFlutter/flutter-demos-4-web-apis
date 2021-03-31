import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:robbinlaw/controllers/authController.dart';
import 'package:robbinlaw/controllers/userController.dart';
import 'package:robbinlaw/controllers/appController.dart';
import 'package:robbinlaw/services/database.dart';
import 'package:robbinlaw/widgets/mycard.dart';

class Home extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print('Home build:');
    Get.find<AppController>().upDate();
    return Scaffold(
      appBar: AppBar(
        title: GetX<UserController>(
          initState: (_) async {
            print("Home Getx<UserController> initState: try");
            try {
              Get.find<UserController>().user = await Database()
                  .getUser(Get.find<AuthController>().firebaseUser.uid);
            } catch (e) {
              print('Home GetX<UserController> initState: catch $e');
            }
          },
          builder: (_) {
            print('Home GetX<UserController> builder: try');
            try {
              //The ? allows us to call on name when the user is null, null safety,
              //and therefore the try will not fail if the user is null.
              if (_.user?.name != null) {
                return Text("User: " + _.user.name);
              } else {
                return Text("loading...");
              }
            } catch (e) {
              print('Home GetX<UserController> builder: catch $e');
              return Text("loading...");
            }
          },
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Get.find<AuthController>().logOut();
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Text(
            "Add Todo Here:",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Card(
            margin: EdgeInsets.all(20),
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
                    icon: Icon(Icons.add),
                    onPressed: () {
                      print('Home +Icon onPressed:');
                      if (_textEditingController.text != "") {
                        Database().addAppData(_textEditingController.text,
                            Get.find<AuthController>().firebaseUser?.uid);
                        _textEditingController.clear();
                      }
                    },
                  )
                ],
              ),
            ),
          ),
          Text(
            "Your Todos",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          GetX<AppController>(
            initState: (_) async {
              print("Home Getx<AppController> initState: try");
            },
            builder: (_) {
              try {
                print("Home Getx<AppController> builder: try");
                if (_ != null && _.appList != null) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: _.appList.length,
                      itemBuilder: (__, index) {
                        return MyCard(
                            userId: Get.find<AuthController>().firebaseUser.uid,
                            appModel: _.appList[index]);
                      },
                    ),
                  );
                } else {
                  return Text("loading...");
                }
              } catch (e) {
                print('Home GetX<AppController> builder: catch $e');
                return Text("loading...");
              }
            },
          )
        ],
      ),
    );
  }
}
