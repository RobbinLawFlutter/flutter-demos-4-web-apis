import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:robbinlaw/controllers/authController.dart';
import 'package:robbinlaw/views/home.dart';
import 'package:robbinlaw/views/login.dart';

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<AuthController>(
      initState: (_) async {
        print("Root Getx<AuthController> initState: try");
      },
      builder: (_) {
        print("Root Getx<AuthController> builder: try");
        try {
          //The ? allows us to call on .uid when the firebaseUser is null, null safety,
          //and therefore the try will not fail if the firebaseUser is null.
          //String presentUid = Get.find<AuthController>().firebaseUser?.uid;
          String? presentUserId = _.firebaseUser?.uid;
          print('Present User = $presentUserId');
          if (presentUserId != null) {
            return Home();
          } else {
            return Login();
          }
        } catch (e) {
          print('Root Getx<AuthController> builder: catch $e');
          return Center(child: Text("fatal error"));
        }
      },
    );
  }
}
