import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:robbinlaw/controllers/authController.dart';
import 'package:robbinlaw/controllers/userController.dart';
import 'package:robbinlaw/controllers/appController.dart';
import 'package:robbinlaw/services/database.dart';
import 'package:robbinlaw/widgets/mycard.dart';

class Home extends GetWidget<AuthController> {
  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Get.find<AppController>().upDate();
    return Scaffold(
      appBar: AppBar(
        title: GetX<UserController>(
          initState: (_) async {
            print("Home Getx<UserController> initState: try");
            try {
              Get.find<UserController>().user = await Database()
                  .getUserTodo(Get.find<AuthController>().firebaseUser.uid);
            } catch (e) {
              print('Home GetX<UserController> initState: catch $e');
            }
          },
          builder: (_) {
            print('Home GetX<UserController> builder: try');
            try {
              if (_.user.name != null) {
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
              controller.logOut();
            },
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              if (Get.isDarkMode) {
                Get.changeTheme(ThemeData.light());
              } else {
                Get.changeTheme(ThemeData.dark());
              }
            },
          )
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
                      if (_textEditingController.text != "") {
                        Database().addTodo(_textEditingController.text,
                            controller.firebaseUser.uid);
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
            builder: (AppController appController) {
              print("Home Getx<AppController> builder:");
              if (appController != null && appController.appList != null) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: appController.appList.length,
                    itemBuilder: (_, index) {
                      return MyCard(
                          uid: controller.firebaseUser.uid,
                          app: appController.appList[index]);
                    },
                  ),
                );
              } else {
                return Text("loading...");
              }
            },
          )
        ],
      ),
    );
  }
}
